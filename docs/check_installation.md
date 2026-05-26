   CHECK INSTALLATION
=========================

## Launch the VM  
    
    lxc launch ubuntu:24.04 workshop  --vm < vm.yaml
    
## Monitor VM during build

    lxc exec workshop -- tail -f /var/log/cloud-init-output.log
    
## Chech VM config and Installed bioinformtics Tools

    lxexec workshop -- bash -lc 'bash -s' < check_installed_tools.sh

Note that `fastp`  is missing!

```    
====================================
  BIOINFO VM AUTO TEST REPORT
====================================

=== SYSTEM ===
Linux workshop 6.8.0-117-generic #117-Ubuntu SMP PREEMPT_DYNAMIC Tue May  5 19:26:24 UTC 2026 x86_64 GNU/Linux

=== CONDA ===
[CHECK] conda ... OK
conda 26.5.0

=== BIOINFORMATICS TOOLS ===
[CHECK] fastp ... MISSING

[CHECK] iqtree ... OK
IQ-TREE version 3.1.2 for Linux x86 64-bit built May 17 2026
Developed by Bui Quang Minh, Thomas Wong, Nhan Ly-Trong, Huaiyan Ren
Contributed by Lam-Tung Nguyen, Dominik Schrempf, Chris Bielow,
Olga Chernomor, Michael Woodhams, Diep Thi Hoang, Heiko Schmidt


[CHECK] nextflow ... OK

      N E X T F L O W
      version 24.10.6 build 5937
      created 23-04-2025 16:53 UTC 
      cite doi:10.1038/nbt.3820
      http://nextflow.io


[CHECK] apptainer ... OK
apptainer version 1.5.0

[CHECK] fastp (conda path) ... MISSING

[CHECK] iqtree (conda path) ... OK
IQ-TREE version 3.1.2 for Linux x86 64-bit built May 17 2026
Developed by Bui Quang Minh, Thomas Wong, Nhan Ly-Trong, Huaiyan Ren
Contributed by Lam-Tung Nguyen, Dominik Schrempf, Chris Bielow,
Olga Chernomor, Michael Woodhams, Diep Thi Hoang, Heiko Schmidt


=== PATH CHECK ===
/shared/tools/miniforge3/condabin:/shared/tools/miniforge3/bin:/usr/local/bin:/shared/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

=== /shared STRUCTURE ===
[OK] /shared exists
[OK] /shared/tools exists
[OK] /shared/fastq_files exists
[OK] /shared/results exists
[OK] /shared/apptainer_images exists
[OK] /shared/conda-pkgs exists
[OK] /shared/conda-envs exists

=== USERS ===
user1:x:1000:1001:User 1:/home/user1:/bin/bash
user2:x:1001:1002:User 2:/home/user2:/bin/bash
user3:x:1002:1003:User 3:/home/user3:/bin/bash
user4:x:1003:1004:User 4:/home/user4:/bin/bash
user5:x:1004:1005:User 5:/home/user5:/bin/bash
user6:x:1005:1006:User 6:/home/user6:/bin/bash
user7:x:1006:1007:User 7:/home/user7:/bin/bash
user8:x:1007:1008:User 8:/home/user8:/bin/bash
user9:x:1008:1009:User 9:/home/user9:/bin/bash
user10:x:1009:1010:User 10:/home/user10:/bin/bash

=== CONDA PACKAGES (bio subset) ===
iqtree                       3.1.2            h8471819_0            bioconda
nextflow                     24.10.6          h2a3209d_0            bioconda

=== APPTAINER TEST ===
[TEST] Apptainer execution test
[OK] Apptainer can run containers

[CHECK] Singularity compatibility
apptainer version 1.5.0

=== NEXTFLOW TEST ===
  Version: 24.10.6 build 5937
  Created: 23-04-2025 16:53 UTC 
  System: Linux 6.8.0-117-generic
  Runtime: Groovy 4.0.23 on OpenJDK 64-Bit Server VM 21.0.10-internal-adhoc.conda.src
  Encoding: UTF-8 (UTF-8)


=== JAVA CHECK ===
[OK] Java found: openjdk version "21.0.10-internal" 2026-01-20
[INFO] Detected Java major version: 21
[OK] Java is compatible with Nextflow (>=17)

=== CONDA JAVA CHECK ===
[OK] Conda Java found: openjdk version "21.0.10-internal" 2026-01-20
=== NEXTFLOW + JAVA COMPATIBILITY ===
[OK] Nextflow found

      N E X T F L O W
[OK] Nextflow + Java are compatible

====================================
  AUTO TEST COMPLETE
```