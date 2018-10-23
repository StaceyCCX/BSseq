#!/bin/bash
DIR=/home/cxchen/Project/chipseq/ASI1_EDM2_peak_macs2/AT_methy_for_peaks
genome=/home/cxchen/Project/genome/TAIR10_chr_all.fas
ADA=/home/cxchen/tool/adapter/TruSeq3-PE.fa
########## sra to fastq #################################
for sample in $@
do 
trim_galore $sample.fastq.gz
mkdir $DIR/fastqc 
fastqc $DIR/$sample.trimmed.fq.gz -o $DIR/fastqc

##############bsmap to calculate methylation level########
mkdir tmp
bsmap -a $DIR/$sample.trimmed.fq.gz -p 2 -d $genome -o tmp/$sample.sam -v 2 #maybe will get segmentation fault 
touch $DIR/tmp/$sample.sam.std
methratio.py -d $genome -u $DIR/tmp/$sample.sam -w $sample.sam.wig -o $DIR/tmp/$ample.sam.std -m 4
done

