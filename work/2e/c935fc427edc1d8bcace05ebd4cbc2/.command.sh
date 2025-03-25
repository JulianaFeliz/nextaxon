#!/bin/bash -euo pipefail
mothur "#make.file(inputdir=UFRN-P1_R1_001-Trimmed.fastq UFRN-P1_R2_001-Trimmed.fastq, outputdir=resultados, type=fastq, prefix=spun);
make.contigs(inputdir=UFRN-P1_R1_001-Trimmed.fastq UFRN-P1_R2_001-Trimmed.fastq, outputdir=resultados, file=spun.files, processors=1);
screen.seqs(fasta=current, group=current, maxambig=4, minlength=300, maxlength=580, maxhomop=22);
unique.seqs();
count.seqs(name=current, group=current);
classify.seqs(fasta=current, count=current, template=1806DB.ng.fasta, taxonomy=1806DB.tax, cutoff=90);
get.lineage(fasta=current, count=current, taxonomy=current, taxon=Glomeromycota);
align.seqs(fasta=current, reference=629ref_aln_cut.fas, flip=t);
screen.seqs(fasta=current, count=current, start=4, end=561);
filter.seqs(fasta=current, vertical=T, trump=.);
unique.seqs(fasta=current, count=current);
pre.cluster(fasta=current, count=current, diffs=3);
split.abund(fasta=current, count=current, cutoff=1, accnos=true);
chimera.vsearch(fasta=spun.trim.contigs.unique.pick.good.filter.unique.precluster.abund.fasta, count=spun.trim.contigs.unique.pick.good.filter.unique.precluster.abund.count_table, dereplicate=t);
remove.seqs(fasta=current, accnos=current);
cluster(fasta=spun.trim.contigs.unique.pick.good.filter.unique.precluster.abund.fasta, count=spun.trim.contigs.unique.pick.good.filter.unique.precluster.abund.count_table, method=dgc, cutoff=0.02);
make.shared(list=current, count=current, label=0.02);
get.oturep(fasta=current, list=current, count=current, label=0.02, method=abundance)"
