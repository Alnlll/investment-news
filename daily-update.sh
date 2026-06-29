#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

START_DAY=$(date +%Y%m%d)
RETRY_INTERVAL=1800  # 30 分钟

while true; do
    TODAY=$(date +%Y%m%d)
    if [ "$TODAY" != "$START_DAY" ]; then
        echo "[$(date)] 已是新的一天 ($TODAY)，跳过重试"
        exit 1
    fi

    echo "[$(date)] ======== 开始每日更新 ========"
    if bash refresh-and-push.sh; then
        echo "[$(date)] ======== 更新成功 ========"
        exit 0
    fi

    echo "[$(date)] 更新失败，${RETRY_INTERVAL}s 后重试..."
    sleep $RETRY_INTERVAL
done
