#!/usr/bin/env bash
source /Users/aln/home/code/python/miniconda/etc/profile.d/conda.sh
conda activate base
export HTTP_PROXY=http://127.0.0.1:7892
export HTTPS_PROXY=http://127.0.0.1:7892
export NO_PROXY=localhost,127.0.0.1
python3 server.py
