Installation Guide
================

## Install LXD

    # Install LXD on the host machine:
    sudo snap install lxd

    #Add your user to the LXD group:
    sudo usermod -aG lxd $USER
    newgrp lxd

    # Initialize LXD
    sudo lxd init



## Clone Repository

    git clone https://github.com/kmezhoud/Workshop_Portability.git

    cd Workshop_Portability

## Network setting

Open `vm.yaml` file and replace network bridge `lxdbr0` and `IP`.

    ## check Host LAN IP
    ip route get 1.1.1.1 | awk '{print $7}'
    ## replace listen: tcp:<YOUR_LAN_IP>:2222

    ## Check the Internal IP
    sudo lxc network show lxdbr0 | grep ipv4.address

## Launch the workshop Container

    lxc launch ubuntu:24.04 workshop --vm < vm.yaml

    # restart container
    lxc restart workshop

    # open shell inside container
    lxc exec workshop -- bash

## Monitor cloud-init Progress

    sudo lxc exec workshop -- tail -f /var/log/cloud-init-output.log
    
    # list lxd containers
    sudo lxc list


### Check Users

    lxc exec workshop -- getent passwd user1

### Check Conda

    sudo lxc exec workshop -- /shared/tools/miniforge3/bin/conda --version

### Check Nextflow

    sudo lxc exec workshop -- nextflow -version

### Check Apptainer

    lxc exec workshop -- apptainer --version

### SSH Access

    #Your SSH client remembers the OLD VM host key, but the new VM generated a NEW SSH key.
    ssh-keygen -f "/home/kirus/.ssh/known_hosts" -R "[192.168.4.64]:2222"

Participants can connect using:

    ssh user1@SERVER_IP -p 2222

Example:

    ssh user3@192.168.4.64 -p 2222

## Shared Directory Structure

    /shared
    ├── fastq_files
    ├── tools
    ├── conda-pkgs
    ├── apptainer_images
    ├── results
    └── references

## Conda Environment Usage

    # Create environment
    conda create -n genomics python=3.12

    # Activate environment
    conda activate genomics

    # Install bioinformatics tools
    conda install -c bioconda fastp samtools iqtree

## Running Nextflow Pipelines

Example:

    nextflow run hello

Example with profile:
     
    # copy file to vm user 1
    lxc file push dataset/samplesheet.csv workshop/home/user1/
     
    nextflow run nf-core/rnaseq -profile conda,test \
      --input samplesheet.csv \
      --outdir test-results

Or you test nextflow pipeline with empty input:
```
user1@workshop:~$ nextflow run nf-core/rnaseq \
   -profile test,conda \
   --outdir test-results

 N E X T F L O W   ~  version 26.04.2

Launching `https://github.com/nf-core/rnaseq` [special_cantor] revision: e7ca46272c [master]

WARN: Unrecognized config option 'validation.defaultIgnoreParams'
WARN: Unrecognized config option 'validation.monochromeLogs'

------------------------------------------------------
                                        ,--./,-.
        ___     __   __   __   ___     /,-._.--~'
  |\ | |__  __ /  ` /  \ |__) |__         }  {
  | \| |       \__, \__/ |  \ |___     \`-._,-`-,
                                        `._,._,'
  nf-core/rnaseq 3.26.0
------------------------------------------------------

Input/output options
  input                                    : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/samplesheet/v3.10/samplesheet_test.csv
  outdir                                   : test-results

Reference genome options
  fasta                                    : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/genome.fasta
  gtf                                      : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/genes_with_empty_tid.gtf.gz
  gff                                      : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/genes.gff.gz
  transcript_fasta                         : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/transcriptome.fasta
  additional_fasta                         : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/gfp.fa.gz
  hisat2_index                             : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/hisat2.tar.gz
  salmon_index                             : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/salmon.tar.gz

Read filtering options
  bbsplit_fasta_list                       : https://raw.githubusercontent.com/nf-core/test-datasets/626c8fab639062eade4b10747e919341cbf9b41a/reference/bbsplit_fasta_list.txt

UMI options
  umitools_bc_pattern                      : NNNN
  umi_discard_read                         : 0

Alignment options
  pseudo_aligner                           : salmon

Quality Control
  kraken_db                                : https://raw.githubusercontent.com/nf-core/test-datasets/eb0cbf73c3f103f8aeda9878ba200e92b4d045d8/data/genomics/sarscov2/genome/db/kraken2.tar.gz

Process skipping options
  skip_bbsplit                             : false

Institutional config options
  config_profile_name                      : Test profile
  config_profile_description               : Minimal test dataset to check pipeline function

Generic options
  trace_report_suffix                      : 2026-05-26_14-30-49

Core Nextflow options
  revision                                 : master
  runName                                  : special_cantor
  container..*PARABRICKS_STARGENOMEGENERATE: (dynamic resolved)
  launchDir                                : /home/user1
  workDir                                  : /home/user1/work
  projectDir                               : /home/user1/.nextflow/assets/.repos/nf-core/rnaseq/clones/e7ca46272c8f9d5ceee3f71759f4ba551d3217a4
  userName                                 : user1
  profile                                  : test,conda
  configFiles                              : /home/user1/.nextflow/assets/.repos/nf-core/rnaseq/clones/e7ca46272c8f9d5ceee3f71759f4ba551d3217a4/nextflow.config

!! Only displaying parameters that differ from the pipeline defaults !!
------------------------------------------------------

* The pipeline
    https://doi.org/10.5281/zenodo.1400710

* The nf-core framework
    https://doi.org/10.1038/s41587-020-0439-x

* Software dependencies
    https://github.com/nf-core/rnaseq/blob/master/CITATIONS.md

WARN: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Both '--gtf' and '--gff' parameters have been provided.
  Using GTF file as priority.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
WARN: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  '--transcript_fasta' parameter has been provided.
  Make sure transcript names in this file match those in the GFF/GTF file.

  Please see:
  https://github.com/nf-core/rnaseq/issues/753
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_GTFFILTER               -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_ADDITIONAL_FASTA        -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_CATADDITIONALFASTA      -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_GTFFILTER               -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_ADDITIONAL_FASTA        -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_CATADDITIONALFASTA      -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:EAUTILS_GTF2BED                -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:SAMTOOLS_FAIDX                 -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_GTFFILTER               -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_ADDITIONAL_FASTA        -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_CATADDITIONALFASTA      -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:EAUTILS_GTF2BED                -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:SAMTOOLS_FAIDX                 -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:BBMAP_BBSPLIT                  -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:STAR_GENOMEGENERATE            -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_GTFFILTER               -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_ADDITIONAL_FASTA        -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_CATADDITIONALFASTA      -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:EAUTILS_GTF2BED                -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:SAMTOOLS_FAIDX                 -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:BBMAP_BBSPLIT                  -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:STAR_GENOMEGENERATE            -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:UNTAR_SALMON_INDEX             -
[-        ] NFCORE_RNASEQ:RNASEQ:SAMTOOLS_INDEX                         -
[-        ] NFC…Q:RNASEQ:FASTQ_QC_TRIM_FILTER_SETSTRANDEDNESS:CAT_FASTQ -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_GTF                     -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_GTFFILTER               -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:GUNZIP_ADDITIONAL_FASTA        -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:CUSTOM_CATADDITIONALFASTA      -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:EAUTILS_GTF2BED                -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:SAMTOOLS_FAIDX                 -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:BBMAP_BBSPLIT                  -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:STAR_GENOMEGENERATE            -
[-        ] NFCORE_RNASEQ:PREPARE_GENOME:UNTAR_SALMON_INDEX             -
[-        ] NFCORE_RNASEQ:RNASEQ:SAMTOOLS_INDEX                         -
[-        ] NFC…Q:RNASEQ:FASTQ_QC_TRIM_FILTER_SETSTRANDEDNESS:CAT_FASTQ -
[-        ] NFC…SEQ:RNASEQ:FASTQ_QC_TRIM_FILTER_SETSTRANDEDNESS:FQ_LINT -
[-        ] NFC…SETSTRANDEDNESS:FASTQ_FASTQC_UMITOOLS_TRIMGALORE:FASTQC -
[-        ] NFC…TRANDEDNESS:FASTQ_FASTQC_UMITOOLS_TRIMGALORE:TRIMGALORE -
[-        ] NFC…Q_QC_TRIM_FILTER_SETSTRANDEDNESS:FQ_LINT_AFTER_TRIMMING -
[-        ] NFC…ASEQ:FASTQ_QC_TRIM_FILTER_SETSTRANDEDNESS:BBMAP_BBSPLIT -
[-        ] NFC…TQ_QC_TRIM_FILTER_SETSTRANDEDNESS:FQ_LINT_AFTER_BBSPLIT -
[-        ] NFC…EQ:FASTQ_QC_TRIM_FILTER_SETSTRANDEDNESS:FASTQC_FILTERED -
[-        ] NFC…_SETSTRANDEDNESS:FASTQ_SUBSAMPLE_FQ_SALMON:FQ_SUBSAMPLE -
[-        ] NFC…_SETSTRANDEDNESS:FASTQ_SUBSAMPLE_FQ_SALMON:SALMON_QUANT -
[-        ] NFCORE_RNASEQ:RNASEQ:ALIGN_STAR:STAR_ALIGN                  -
[-        ] NFC…RNASEQ:ALIGN_STAR:BAM_SORT_STATS_SAMTOOLS:SAMTOOLS_SORT -
[-        ] NFC…NASEQ:ALIGN_STAR:BAM_SORT_STATS_SAMTOOLS:SAMTOOLS_INDEX -
[-        ] NFC…M_SORT_STATS_SAMTOOLS:BAM_STATS_SAMTOOLS:SAMTOOLS_STATS -
[-        ] NFC…ORT_STATS_SAMTOOLS:BAM_STATS_SAMTOOLS:SAMTOOLS_FLAGSTAT -
[-        ] NFC…ORT_STATS_SAMTOOLS:BAM_STATS_SAMTOOLS:SAMTOOLS_IDXSTATS -
[-        ] NFCORE_RNASEQ:RNASEQ:QUANTIFY_BAM_SALMON:SALMON_QUANT       -
[-        ] NFC…LMON:QUANT_TXIMPORT_SUMMARIZEDEXPERIMENT:CUSTOM_TX2GENE -
[-        ] NFC…ON:QUANT_TXIMPORT_SUMMARIZEDEXPERIMENT:TXIMETA_TXIMPORT -
[-        ] NFC…MON:QUANT_TXIMPORT_SUMMARIZEDEXPERIMENT:SE_GENE_UNIFIED -
Plus 37 more processes waiting for tasks…
Creating env using conda: /home/user1/.nextflow/assets/.repos/nf-core/rnaseq/clones/e7ca46272c8f9d5ceee3f71759f4ba551d3217a4/modules/nf-core/gunzip/environment.yml [cache /home/user1/work/conda/env-4e7a2806bf21778d59d5eb71300de9f9]
Staging foreign file: https://raw.githubusercontent.com/nf-core/test-datasets/rnaseq/testdata/GSE110004/SRR6357073_1.fastq.gz
Staging foreign file: https://raw.githubusercontent.com/nf-core/test-datasets/rnaseq/testdata/GSE110004/SRR6357074_1.fastq.gz
Creating env using conda: /home/user1/.nextflow/assets/.repos/nf-core/rnaseq/clones/e7ca46272c8f9d5ceee3f71759f4ba551d3217a4/modules/nf-core/fq/lint/environment.yml [cache /home/user1/work/conda/env-2f5ff867a25b387610712ebd44cbb455]
Staging foreign file: https://raw.githubusercontent.com/nf-core/test-datasets/rnaseq/testdata/GSE110004/SRR6357072_2.fastq.gz
WARN: The operator `first` is useless when applied to a value channel which returns a single value by definition
Killed
user1@workshop:~$

```
## Using Apptainer

Pull container:

    apptainer pull docker://ubuntu:24.04

Run container:

    apptainer exec ubuntu_24.04.sif bash

## Backup and Portability

Export the entire workshop:

    lxc export workshop workshop.tar.gz

Restore:

    lxc import workshop.tar.gz

This allows:

- portable workshops
- offline deployment
- rapid infrastructure recovery

## Updating the Environment

Enter container:

    lxc exec workshop -- bash

Update Conda:

    conda update -n base -c conda-forge conda

Update packages:

    conda install nextflow --solver=classic

    conda update --all
