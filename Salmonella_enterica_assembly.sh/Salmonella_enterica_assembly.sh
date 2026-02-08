#!/usr/bin/env bash

#Salmonella enterica Consensus Genome Assembly & Alignment

#--------------------------------------

#Create the environment for assembly & environment
conda create --name plasmid_assembly
conda activate plasmid_assembly
conda install flye
conda install bioconda:medaka
conda install bioconda:quast
conda install bioconda:minimap2
conda install bioconda:samtools
conda install -c bioconda seqkit

#--------------------------------------

#Collect sequence stats about the reference genome using the "seqkit" package
seqkit stats GCA_000006945.2_ASM694v2_genomic.fna

#Total reference sequence length = 4,951,383 (~4.95m bp)

#--------------------------------------

#Assemble the consensus genome from ONT-R10 raw reads using Flye (3 trials to check discrepancies)
flye --nano-raw SRR32410565.fastq -o Salmonella_assembly -t 32
flye --nano-raw SRR32410565.fastq -o Salmonella_assembly_2 -t 32
flye --nano-raw SRR32410565.fastq -o Salmonella_assembly_3 -t 32

#Output files: "assembly.fasta", "assembly_2.fasta", "assembly_3.fasta"

#Since the assembly stats between trials had no significant differences, "assembly.fasta" was used for subsequent steps.

#Check sequence stats for assembly
seqkit stats assembly.fasta

#--------------------------------------

#Polishing consensus genome with Medaka (model: r103_sup_g507 for ONT-R10 flowcells)
medaka_consensus -i SRR32410565.fastq -d assembly.fasta -o Salmonella_enterica_medaka -t 16 -m r103_sup_g507

#Threads were set to 16 to allow RAM space for polishing and constructing files.
#Output file: "consensus.fasta"


#Check sequence stats for polished consensus
seqkit stats consensus.fasta


#NOTE: The Flye and Medaka assembly FASTA files can now be used to visualize plasmid maps in Proksee.

#--------------------------------------

#Quality Assessment Tool for Genome Assemblies (QUAST)

#For the original Flye consensus assembly (unpolished)
quast assembly.fasta -r GCA_000006945.2_ASM694v2_genomic.fna -o Salmonella_quast_assembly

#For the Medaka consensus (polished)
quast consensus.fasta -r GCA_000006945.2_ASM694v2_genomic.fna -o Salmonella_quast_medaka

#--------------------------------------

#Alignment of consensus genome to reference genome with minimap2

#For Flye assembly alignment
minimap2 -ax asm10 -t 32 GCA_000006945.2_ASM694v2_genomic.fna assembly.fasta > Flye_vs_ref.sam

#For Medaka assembly alignment
minimap2 -ax asm10 -t 32 GCA_000006945.2_ASM694v2_genomic.fna consensus.fasta > Medaka_vs_ref.sam


#Sort and index Flye alignment
samtools view -bS flye_vs_ref.sam -o flye_vs_ref.bam
samtools sort flye_vs_ref.bam -o flye_vs_ref_sorted.bam
samtools index flye_vs_ref_sorted.bam


#Sort and index Medaka alignment
samtools view -bS medaka_vs_ref.sam -o medaka_vs_ref.bam
samtools sort medaka_vs_ref.bam -o medaka_vs_ref_sorted.bam
samtools index medaka_vs_ref_sorted.bam

#--------------------------------------

#Variant Calling with Clair3 in Singularity/Apptainer container

#Prepare read-vs-reference alignment for variant calling
minimap2 -ax map-ont -t 32 GCA_000006945.2_ASM694v2_genomic.fna SRR32410565.fastq > read_vs_ref.sam

#Index reference genome
samtools faidx GCA_000006945.2_ASM694v2_genomic.fna

#Sort and index read-vs-reference alignment
samtools view -bS read_vs_ref.sam -o read_vs_ref.bam
samtools sort read_vs_ref.bam -o read_vs_ref_sorted.bam
samtools index read_vs_ref_sorted.bam

#Make the output directory for variant calling results
mkdir Salmonella_enterica_clair3_out

#Run Clair3 variant calling in Singularity/Apptainer container
singularity exec \
-B /home/cakbarally/binf6110/assignment_1,/home/cakbarally/binf6110/assignment_1/Salmonella_enterica_clair3_out \
clair3_latest.sif \
/opt/bin/run_clair3.sh \
--bam_fn=/home/cakbarally/binf6110/assignment_1/read_vs_ref_sorted.bam \
--ref_fn=/home/cakbarally/binf6110/assignment_1/GCA_000006945.2_ASM694v2_genomic.fna \
--threads=32 \
--platform="ont" \
--model_path="/opt/models/r1041_e82_400bps_sup_v500" \
--include_all_ctgs \
--output /home/cakbarally/binf6110/assignment_1/Salmonella_enterica_clair3_out \
--no_phasing_for_fa  #Salmonella enterica is a haploid organism

#Unzip for IGV visualization
gunzip Salmonella_enterica_clair3_out/merge_output.vcf.gz

#--------------------------------------

#All necessary files should now be created for Proksee visualization (for consensus maps) and IGV visualization.

#END OF SCRIPT
