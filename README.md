# binf6110-assignment-1

## Introduction
Bacterial genome assembly has been recognized as an essential milestone for researching a variety of prokaryotic species (Land et al., 2015).  Since 1995, advancements over three generations of DNA sequencing have greatly illustrated the improvements in information for genomic studies, including time, cost, and public genome library sizes for a variety of bacteria (Land et al., 2015).  The most predominant approach for constructing bacterial genomes has often been *de novo* assembly of raw reads, with different methods being introduced over time based on their length, either short, long, or a combination of both (Zhang et al., 2021).  Historically, short-read sequencing, like Illumina, was used primarily to assemble genomes using sample libraries often prepared from amplification (Zhang et al., 2021).  However, while these techniques still continue to be used today and are the most accurate, their limitations mainly prevent them from being viable for complete assembly of much more complex genomes (Zhang et al., 2021).  Today, the emergence of new long-read sequencing techniques, especially Oxford Nanopore Technologies (ONT), have been instrumental in reshaping the pace and effectiveness of genome assembly with several more base pairs per read (Sereika et al., 2022).  ONT R10, in particular, has been most recently useful (Sereika et al., 2022) for assembling consensus genome sequences that almost reach completion, without using short reads (Sereika et al., 2022).  Other long-read techniques, like PacBio, have also been key for assembling prokaryotic sequences, especially when working with the 16S rRNA gene (Buetas et al., 2024).  Despite these advancements, though, they also introduce some key limitations of their own, especially in clinical applications, including accuracy in distinguishing genetic variants, expensive “cost per base”, and data quality (Oehler et al., 2023).  As such, it is necessary to evaluate how different long-read techniques can be used to assemble accurate consensus genomes and align them to a reference genome.

*Salmonella enterica*, a highly known foodborne bacterial pathogen to humans, has been widely studied by researchers to determine the best methods for constructing its full genome (Chattaway et al., 2021).  A key challenge, though, for assembly of this species has been aligning and accounting for variation in over 2000 different serovars, or variants, due to differences in their antigens (Chattaway et al., 2021).  Over time, methods such as whole-genome sequencing (WGS) have been used to further construct the phylogeny of these serovars, establishing at least two further clades of the subspecies *enterica* (Worley et al., 2018).  Additionally, ONT has started to be used for applying long-read sequencing of *Salmonella enterica* for detection and evaluation of genetic differences in serotyping (Thomas et al., 2023).  Nonetheless, even with the limitations that still remain with long-read techniques, it is still important to evaluate the best choices that can yield the highest quality consensus genomes for distinguishing separate isolates.

In this analysis, the goal was to assemble and align a consensus genome from ONT R10 long reads of *Salmonella enterica*, primarily by using Flye *de novo* assembly (Kolmogorov et al., 2019).  Flye has been shown to provide a greater amount of contiguity, especially when compared to other familiar long-read techniques such as Canu, Miniasm, and more, leading to more complete assemblies at a slightly faster rate (Kolmogorov et al., 2019).  Additionally, according to prior research conducted by Lamas et al., which compared at least four different de novo assembly software, there is further evidence that Flye has shown better performance in other areas of bioinformatic research on *Salmonella* from gene assembly, especially with serotyping (2023).  Despite this, a key limitation of Flye is its high memory usage, to the point where some researchers have attempted to potentially discover new compact methods of using Flye that require less memory, though this research currently remains limited (Freire et al., 2022).  Nonetheless, Flye continues to remain today as one of the top leaders for long-read sequencing techniques for large genomes, including *Salmonella enterica* (Kolmogorov et al., 2019, Lamas et al., 2023).

## Proposed Methods
ONT R10 raw reads of *Salmonella enterica* were obtained from the SRR32410565 isolate on the National Centre for Biotechnology Information (NCBI) database (NCBI, 2023).  The reads were then assembled using de novo assembly with Flye v2.9.6-b1802, a more recent model closer to the one that has been used prior for serotyping (Lamas et al., 2023).  The resulting consensus assembly then underwent polishing steps using the software Medaka v2.2.0 (Oxford Nanopore Technologies Ltd., 2018, Anaconda, n.d.).  Medaka has often displayed more accuracy with Nanopore samples, correcting more errors, and it has also been used alongside Flye for polishing assemblies for serotyping research (Luan et al., 2024, Lamas et al., 2023).  For quality control (QC) steps, QUAST v5.3.0 was used to evaluate the quality of the consensus genome against the *Salmonella enterica* reference genome from NCBI (Mikheenko et al., 2024, NCBI, 2023).  QUAST has been a valuable quality control tool for comparing bacterial genome assemblies against their reference genomes (Gurevich et al., 2013).  Once the consensus genome was assessed for quality, Minimap2 v2.30-r1287 was used to align the consensus genome with the reference genome (Li et al., 2025, NCBI, 2023).  Finally, for visualization of the alignment in IGV v2.19.7, SAMtools v1.2.3 was used to convert, sort, and index into BAM format (IGV, n.d., SAMtools, n.d.).

## References
Anaconda. (n.d.). medaka. https://anaconda.org/channels/bioconda/packages/medaka/overview

Buetes, E., Jordan-Lopez, M., Lopez-Roldan, A., D’Auria, G., Martinez-Priego, L., De Marco, G., Carda-Dieguez, & Mira, A. (2024). Full-length 16S rRNA gene sequencing by PacBio improves taxonomic resolution in human microbiome samples. *BMC Genomics*, *25*, 310. https://doi.org/10.1186/s12864-024-10213-5

Chattaway, M., Langridge, G. C., & Wain, J. (2021). *Salmonella* nomenclature in the genomic era: a time for change. *Scientific Reports*, *11*, 7494. https://doi.org/10.1038/s41598-021-86243-w

Freire, B., Ladra, S., & Parama, J. R. (2022). Memory-Efficient Assembly Using Flye. *IEEE/ACM Transactions on Computational Biology and Bioinformatics*, *19*:6, 3564-3577. https://doi.org/10.1109/TCBB.2021.3108843

Gurevich, A., Saveliev, V., Vyahhi, N., & Tesler, G. (2013). QUAST: quality assessment tool for genome assemblies. *Bioinformatics*, *29*(8), 1072-1075. https://doi.org/10.1093/bioinformatics/btt086

IGV Desktop Application. (n.d.) IGV version 2.19.7. https://igv.org/doc/desktop/#DownloadPage/

Kolmogorov, M., Yuan, J., Lin, Y., & Pevzner, P. A. (2019). Assembly of long, error-prone reads using repeat graphs. *Nature Biotechnology*, *37*, 540-546. https://doi.org/10.1038/s41587-019-0072-8

Lamas, A., Garrido-Maestu, A., Prieto, A., Cepeda, A., & Franco, C. M. (2023). Whole genome sequencing in the palm of your hand: how to implement a MinION Galaxy-based workflow in a food safety laboratory for rapid Salmonella spp. serotyping, virulence, and antimicrobial resistance gene identification. *Frontiers in Microbiology*, *14*:1254692. https://doi.org/10.3389/fmicb.2023.1254692

Land, M., Hauser, L., Jun, S. R., Nookaew, I., Leuze, M. R., Ahn, T. K., Karpinets, T., Lund, O., Kora, G., Wassenaar, T., Poudel, S., & Ussery, D. W. (2015). Insights from 20 years of bacterial genome sequencing. *Functional & Integrative Genomics*, *15*, 141-161. https://doi.org/10.1007/s10142-015-0433-4

Li, H., et al. (2025). minimap2. https://github.com/lh3/minimap2

Luan, T., Commichaux, S., Hoffmann, M., Jayeola, V., Jang, J. H., Pop, M., Rand, H., & Luo, Y. (2024). Benchmarking short and long read polishing tools for nanopore assemblies: achieving near-perfect genomes for outbreak isolates. *BMC Genomics*, *25*, 679. https://doi.org/10.1186/s12864-024-10582-x

Mikheenko, A., Gurevich, A., Savelyev, V., Vyahhi, N., Cokelaer, T., Komissarov, A., Lebedeva, E., Turischeva, P., Jackman, S., Ziemski, M., Kleschin, A., & Rossini, R. (2024). quast. https://github.com/ablab/quast

NCBI. (2023). WGS of Salmonella enterica isolate (SRR32410565). *NCBI*. https://trace.ncbi.nlm.nih.gov/Traces/?run=SRR32410565

Oehler, J. B., Wright, H., Stark, Z., Mallett, A. J., & Schmitz, U. (2023). The application of long-read sequencing in clinical settings. *Human Genomics*, *17*, 73. https://doi.org/10.1186/s40246-023-00522-3

Oxford Nanopore Technologies Ltd. (2018). Medaka. https://github.com/nanoporetech/medaka/blob/v2.1.1/README.md

SAMtools (v1.2.3). n.d. https://www.htslib.org/download/

Sereika, M., Kirkegaard, R. H., Karst, S. M., Michaelsen, T. Y., Sorenson, E. A., Wollenberg, R. M., & Albertsen, M. (2022). Oxford Nanopore R10.4 long-read sequencing enables the generation of near-finished bacterial genomes from pure cultures and metagenomes without short-read or reference polishing. *Nature Methods*, *19*, 823-826. https://doi.org/10.1038/s41592-022-01539-7

Thomas, C., Methner, U., Marz, M., & Linde, J. (2023). Oxford nanopore technologies—a valuable tool to generate whole-genome sequencing data for *in silico* serotyping and the detection of genetic markers in *Salmonella*. *Frontiers in Veterinary Science*, *10*, 1178922. https://doi.org/10.3389/fvets.2023.1178922

Worley, J., Meng, J., Allard, M. W., Brown, E. W., & Timme, R. E. (2018). Salmonella enterica Phylogeny Based on Whole-Genome Sequencing Reveals Two New Clades and Novel Patterns of Horizontally Acquired Genetic Elements. *ASM Journals*, *9*:10.1128. https://doi.org/10.1128/mbio.02303-18

Zhang, P., Jiang, D., Wang, Y., Yao, X., Luo, Y., & Yang, Z. (2021). Comparison of De Novo Assembly Strategies for Bacterial Genomes. International Journal of Molecular Sciences, 22(14), 7668. https://doi.org/10.3390/ijms22147668
