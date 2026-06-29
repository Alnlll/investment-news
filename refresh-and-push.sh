#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

source /Users/aln/home/code/python/miniconda/etc/profile.d/conda.sh
conda activate base
export HTTP_PROXY=http://127.0.0.1:7892
export HTTPS_PROXY=http://127.0.0.1:7892

echo "=== 1/3 抓取 RSS ==="
python3 scripts/fetch.py

echo ""
echo "=== 2/3 AI 摘要 ==="
python3 scripts/digest.py

echo ""
echo "=== 3/3 推送到 GitHub ==="
if git diff --quiet data.js; then
    echo "data.js 无变化，跳过推送"
else
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
    git add data.js
    git commit -m "auto: update data @ $TIMESTAMP"
    git push
    echo "✅ 已推送更新"
fi
