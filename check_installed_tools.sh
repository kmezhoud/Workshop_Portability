#!/usr/bin/env bash

echo "===================================="
echo "  BIOINFO VM AUTO TEST REPORT"
echo "===================================="
echo ""

# ---------- helper ----------
check() {
    name=$1
    cmd=$2

    echo -n "[CHECK] $name ... "

    if eval "$cmd" >/dev/null 2>&1; then
        echo "OK"
        eval "$cmd"
    else
        echo "MISSING"
    fi

    echo ""
}

# ---------- SYSTEM ----------
echo "=== SYSTEM ==="
uname -a
echo ""

# ---------- CONDA ----------
echo "=== CONDA ==="
check "conda" "/shared/tools/miniforge3/bin/conda --version"

# ---------- BIO TOOLS ----------
echo "=== BIOINFORMATICS TOOLS ==="

check "fastp" "fastp --version"
check "iqtree" "iqtree --version"
check "nextflow" "nextflow -version"
check "apptainer" "apptainer --version"
check "mafft" "mafft --version"

# conda-installed fallback checks
check "fastp (conda path)" "/shared/tools/miniforge3/bin/fastp --version"
check "iqtree (conda path)" "/shared/tools/miniforge3/bin/iqtree --version"
check "mafft (conda path)" "/shared/tools/miniforge3/bin/mafft --version"

# ---------- PATH ----------
echo "=== PATH CHECK ==="
echo "$PATH"
echo ""

# ---------- SHARED DIRS ----------
echo "=== /shared STRUCTURE ==="

for d in \
/shared \
/shared/tools \
/shared/fastq_files \
/shared/results \
/shared/apptainer_images \
/shared/conda-pkgs \
/shared/conda-envs
do
    if [ -d "$d" ]; then
        echo "[OK] $d exists"
    else
        echo "[MISSING] $d"
    fi
done

echo ""

# ---------- USERS ----------
echo "=== USERS ==="
getent passwd | grep -E "user[0-9]+" || echo "No users found"

echo ""

# ---------- CONDA LIST ----------
echo "=== CONDA PACKAGES (bio subset) ==="
/shared/tools/miniforge3/bin/conda list 2>/dev/null | egrep "fastp|iqtree|mafft|nextflow|apptainer|samtools|bwa" || echo "conda not accessible"

echo ""

# ---------- APPTAINER TEST ----------
echo "=== APPTAINER TEST ==="

echo "[TEST] Apptainer execution test"

if command -v apptainer >/dev/null 2>&1; then
    if apptainer exec docker://alpine echo "Apptainer OK" >/dev/null 2>&1; then
        echo "[OK] Apptainer can run containers"
    else
        echo "[FAIL] Apptainer exists but cannot run containers"
    fi
else
    echo "[SKIP] Apptainer not installed"
fi

echo ""

echo "[CHECK] Singularity compatibility"

if command -v singularity >/dev/null 2>&1; then
    singularity --version
else
    echo "[INFO] singularity command not found (ok for Apptainer-only systems)"
fi

echo ""

# ---------- NEXTFLOW TEST ----------
echo "=== NEXTFLOW TEST ==="

if command -v nextflow >/dev/null 2>&1; then
    nextflow info | head -n 20
else
    echo "Nextflow not found"
fi

echo ""
# ---------- JAVA TEST ----------
echo "=== JAVA CHECK ==="

# Detect Java
if command -v java >/dev/null 2>&1; then
    JAVA_VER=$(java -version 2>&1 | head -n 1)
    echo "[OK] Java found: $JAVA_VER"

    # Extract major version (works for modern + old formats)
    JAVA_MAJOR=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F. '{print $1}')

    echo "[INFO] Detected Java major version: $JAVA_MAJOR"

    if [ "$JAVA_MAJOR" -ge 17 ]; then
        echo "[OK] Java is compatible with Nextflow (>=17)"
    else
        echo "[FAIL] Java is too old for Nextflow (need >=17)"
    fi
else
    echo "[MISSING] Java not installed"
fi

echo ""

echo "=== CONDA JAVA CHECK ==="

if [ -f /shared/tools/miniforge3/bin/java ]; then
    CONDA_JAVA=$(/shared/tools/miniforge3/bin/java -version 2>&1 | head -n 1)
    echo "[OK] Conda Java found: $CONDA_JAVA"
else
    echo "[INFO] No Java inside conda environment"
fi
echo "=== NEXTFLOW + JAVA COMPATIBILITY ==="

if command -v nextflow >/dev/null 2>&1; then
    echo "[OK] Nextflow found"
    NEXTFLOW_VERSION=$(nextflow -version 2>&1 | head -n 2)
    echo "$NEXTFLOW_VERSION"

    JAVA_MAJOR=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F. '{print $1}')

    if [ "$JAVA_MAJOR" -ge 17 ]; then
        echo "[OK] Nextflow + Java are compatible"
    else
        echo "[FAIL] Nextflow requires Java >=17"
    fi
else
    echo "[MISSING] Nextflow not installed"
fi

echo ""
echo "===================================="
echo "  AUTO TEST COMPLETE"
echo "===================================="