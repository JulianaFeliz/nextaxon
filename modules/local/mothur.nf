#!/usr/bin/env nextflow

process MOTHUR_ANALYSIS {
    tag "mothur_analysis"
    publishDir "${params.outdir}/mothur", mode: 'copy'

    input:
    tuple val(id), path(inputdir)
    path outputdir
    path ref_1806DB_fasta
    path ref_1806DB_tax
    path ref_629_aln_cut


    output:
    tuple val(params.prefix), path("${params.prefix}.trim.contigs.unique.pick.good.filter.unique.precluster.abund.pick.rep.fasta"), emit: rep_fasta
    path "${params.prefix}.trim.contigs.unique.pick.good.filter.unique.precluster.abund.pick.shared", emit: shared_file
    path "*.taxonomy", emit: taxonomy
    path "*.count_table", emit: count_table
    path "*.list", emit: list_file

    script:
    """
    mothur "#make.file(inputdir=${inputdir}, outputdir=${outputdir}, type=fastq, prefix=${params.prefix});
    make.contigs(inputdir=${inputdir}, outputdir=${outputdir}, file=${params.prefix}.files, processors=${task.cpus});
    screen.seqs(fasta=current, group=current, maxambig=4, minlength=300, maxlength=580, maxhomop=22);
    unique.seqs();
    count.seqs(name=current, group=current);
    classify.seqs(fasta=current, count=current, template=${ref_1806DB_fasta}, taxonomy=${ref_1806DB_tax}, cutoff=90);
    get.lineage(fasta=current, count=current, taxonomy=current, taxon=Glomeromycota);
    align.seqs(fasta=current, reference=${ref_629_aln_cut}, flip=t);
    screen.seqs(fasta=current, count=current, start=4, end=561);
    filter.seqs(fasta=current, vertical=T, trump=.);
    unique.seqs(fasta=current, count=current);
    pre.cluster(fasta=current, count=current, diffs=3);
    split.abund(fasta=current, count=current, cutoff=1, accnos=true);
    chimera.vsearch(fasta=${params.prefix}.trim.contigs.unique.pick.good.filter.unique.precluster.abund.fasta, count=${params.prefix}.trim.contigs.unique.pick.good.filter.unique.precluster.abund.count_table, dereplicate=t);
    remove.seqs(fasta=current, accnos=current);
    cluster(fasta=${params.prefix}.trim.contigs.unique.pick.good.filter.unique.precluster.abund.fasta, count=${params.prefix}.trim.contigs.unique.pick.good.filter.unique.precluster.abund.count_table, method=dgc, cutoff=0.02);
    make.shared(list=current, count=current, label=0.02);
    get.oturep(fasta=current, list=current, count=current, label=0.02, method=abundance)"
    """
}
