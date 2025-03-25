#!/bin/bash -euo pipefail
mothur "#make.file(inputdir=., outputdir=., type=fastq, prefix=UFRN-D1);
make.contigs(file=UFRN-D1.files, outputdir=., processors=1);
screen.seqs(fasta=UFRN-D1.trim.contigs.fasta, group=UFRN-D1.contigs.groups, maxambig=4, minlength=300, maxlength=580, maxhomop=22);
unique.seqs(fasta=current);
count.seqs(name=current, group=current);
classify.seqs(fasta=current, count=current, reference=1806DB.ng.fasta, taxonomy=1806DB.tax, cutoff=90);
get.lineage(fasta=current, count=current, taxonomy=current, taxon=Glomeromycota);
align.seqs(fasta=current, reference=629ref_aln_cut.fas, flip=t);
screen.seqs(fasta=current, count=current, start=4, end=561);
filter.seqs(fasta=current, vertical=T, trump=.);
unique.seqs(fasta=current, count=current);
pre.cluster(fasta=current, count=current, diffs=3);
split.abund(fasta=current, count=current, cutoff=1, accnos=true);
chimera.vsearch(fasta=current, count=current, dereplicate=t);
remove.seqs(fasta=current, accnos=current);
cluster(fasta=current, count=current, method=dgc, cutoff=0.02);
make.shared(list=current, count=current, label=0.02);
get.oturep(fasta=current, list=current, count=current, label=0.02, method=abundance)"
