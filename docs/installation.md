Installation Guide
================

## Install LXD

    # Install LXD on the host machine:
    sudo snap install lxd

    #Add your user to the LXD group:
    sudo usermod -aG lxd $USER
    newgrp lxd

    # Initialize LXD
    lxd init

## Network setting

Replace network bridge `lxdbr0` and `IP` in cloud config `vm.yaml` file.

    ## check Host LAN IP
    # ip route get 1.1.1.1 | awk '{print $7}'
    ## replace listen: tcp:<YOUR_LAN_IP>:2222

    ## Check the Internal IP
    #  sudo lxc network show lxdbr0 | grep ipv4.address

## Clone Repository

    git clone https://github.com/kmezhoud/Workshop_Portability.git

    cd Workshop_Portability

## Launch the wrkshop Container

    lxc launch ubuntu:24.04 workshop --vm < vm.yaml

    # restart container
    lxc restart workshop

    # open shell inside container
    lxc exec workshop -- bash

## Monitor cloud-init Progress

    lxc exec workshop -- tail -f /var/log/cloud-init-output.log

## verify Installation

### Check Users

    lxc exec workshop -- getent passwd user1

### Check Conda

    lxc exec workshop -- /shared/tools/miniforge3/bin/conda --version

### Check Nextflow

    lxc exec workshop -- nextflow -version

### Check Apptainer

    lxc exec workshop -- apptainer --version

### SSH Access

Participants can connect using:

    ssh user1@SERVER_IP -p 2222

Example:

    ssh user3@192.168.1.10 -p 2222

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

    nextflow run nf-core/rnaseq -profile conda

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

    conda update --all
