
# Bioinformatics Workshop Containerization Platform

A reproducible multi-user bioinformatics workshop environment built with LXD system containers, 
shared Conda environments, Nextflow pipelines, and Apptainer support.

# Why Containerize a Workshop?

Bioinformatics workshops are notoriously difficult to deploy consistently across multiple computers, 
users, and operating systems. Participants often spend more time resolving software conflicts than 
learning scientific workflows.

Containerization solves these challenges by providing a portable, reproducible,
and isolated training environment where every participant accesses the exact same infrastructure.

This project transforms a standard Linux server into a lightweight multi-user 
bioinformatics platform that behaves like a small HPC training cluster.

# Objectives

This platform was designed to:

- provide a reproducible bioinformatics teaching environment
- eliminate software dependency conflicts
- simplify workshop deployment
- support multiple simultaneous users
- centralize computational resources
- reduce setup time during training sessions
- improve workflow reproducibility
- enable offline or portable workshop deployment

# Documentation Links

| Section | Description |
|---|---|
| [Installation](docs/installation.md#install-LXD) | Deploy the workshop container |
| [Network](docs/installation.md#network-setting) | Network Setting |
| [Architecture](docs/installation.md#shared-directory-structure) | Infrastructure overview |
| [Users & SSH](docs/installation.md#check-users) | Multi-user access |
| [Conda](docs/installation.md#conda-environment-usage) | Conda Environment Usage |
| [Nextflow](docs/installation.md#running-nextflow-pipelines) | Workflow execution |
| [Backup & Restore](docs/installation.md#backup-and-portability) | Export and restore containers |
| [Update the Environment](docs/installation.md#updating-the-environment) | conda update |
| [Check Installation](docs/check_installation.md) | check VM config and Tools |

# Default Bioinformatics Tools Installed

The following bioinformatics tools are pre-installed or supported in the workshop VM environment.

---

# Core Bioinformatics Tools

| Tool | Description | Installation Method | Source |
|---|---|---|---|
| fastp | FASTQ quality control and preprocessing | Conda (base) | Bioconda |
| iqtree | Phylogenetic tree inference | Conda (base) | Bioconda |
| mafft | Multiple sequence alignment | Conda (base) | Bioconda |
| chewBBACA | cgMLST / wgMLST bacterial allele calling suite | Conda (base) | Bioconda |
| Bactopia | Bacterial genome analysis pipeline | Conda + Nextflow | Bioconda |
| Bacass *(optional)* | Assembly assessment workflow | Nextflow pipeline | nf-core |

---

# Workflow & Runtime Components

| Component | Purpose | Installation Method |
|---|---|---|
| Nextflow | Workflow orchestration engine | Official binary |
| OpenJDK 21 | Java runtime required by Nextflow | Ubuntu package |
| Apptainer | Container runtime for nf-core pipelines | Ubuntu package |
| Miniforge3 | Shared Conda package manager | Official installer |

---


# Why Use System Containers Instead of Traditional Workstations?

Traditional workshop deployment usually requires:

- installing software individually on each machine
- managing incompatible package versions
- resolving Conda conflicts repeatedly
- handling different operating systems
- troubleshooting participant laptops
- consuming large amounts of setup time

Using system containers allows instructors to deploy a fully preconfigured Linux 
environment where all participants work under identical conditions.

# Advantages of Containerized Workshops

## Reproducibility

Every participant receives the same:

- Linux environment
- Conda configuration
- workflow engine
- bioinformatics tools
- permissions
- datasets
- execution paths

This dramatically improves scientific reproducibility.

## Simplified Deployment

A complete workshop can be distributed as:

- a single container image
- an exported backup
- a USB portable environment
- a local server appliance

Deployment time becomes minutes instead of days.

## Reduced Technical Support

Participants no longer need to:

- install software locally
- resolve package conflicts
- configure PATH variables
- manage Conda channels
- troubleshoot Java dependencies
- install workflow engines manually

This allows instructors to focus on science rather than system administration.

## Multi-User Shared Infrastructure

The platform supports:

- multiple simultaneous SSH users
- shared datasets
- shared Conda package cache
- centralized workflow execution
- collaborative analysis
- isolated user home directories

## Efficient Resource Utilization

Instead of requiring powerful laptops for every participant, a single server can provide:

- centralized CPU resources
- shared memory
- shared storage
- optimized package caches
- common workflow databases

This is particularly useful for genomics and high-throughput sequencing workshops.

# Why Use LXD Instead of Docker?

This project uses LXD because it provides full Linux system containers rather than isolated application containers.

Advantages include:

- native SSH support
- persistent multi-user sessions
- systemd compatibility
- easier shared filesystem management
- improved HPC workflow compatibility
- better support for Apptainer
- lower overhead than virtual machines

The resulting environment behaves like a lightweight Linux server rather than 
a simple containerized application.

# Included Technologies

## Workflow Management

- Nextflow

## Container Runtime

- Apptainer

## Environment Management

- Conda / Miniforge
- Shared package cache
- Multi-user Infrastructure
- OpenSSH server
- Shared storage
- ACL permissions
- Group-based collaboration

# Typical Use Cases

This platform is suitable for:

- genomics workshops
- metagenomics training
- HPC bioinformatics courses
- university teaching laboratories
- reproducible research demonstrations
- sequencing data analysis training
- offline teaching environments
- portable scientific classrooms

# Architecture Overview

```
Host Server
│
├── LXD Container
│     ├── SSH Server
│     ├── User Accounts
│     ├── Shared Conda
│     ├── Nextflow
│     ├── Apptainer
│     └── Shared Datasets
│
└── Shared Persistent Storage

```

# Benefits for Instructors

Instructors can:

- prepare the environment once
- distribute identical environments repeatedly
- snapshot workshop states
- export environments to external drives
- restore environments rapidly
- maintain version consistency across sessions
- Benefits for Participants

Participants can:

- connect using SSH
- immediately run workflows
- focus on analysis rather than installation
- access standardized datasets
- reuse workflows after training
- work from low-spec computers

# Portable Scientific Infrastructure

The complete workshop can be:

- exported as a container image
- backed up to external storage
- redeployed on another server
- transported between laboratories
- reused for future workshops

This makes the platform particularly useful for institutions with limited infrastructure resources.



# Conclusion

Containerized workshops represent a modern approach to scientific training infrastructure. By combining lightweight system containers, shared bioinformatics tooling, and reproducible workflow management, this platform simplifies training deployment while improving reliability, portability, and scientific reproducibility.

The result is a scalable and portable teaching environment capable of supporting modern bioinformatics education with minimal operational overhead.