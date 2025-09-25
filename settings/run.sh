#!/bin/sh

NUM_PROCESSES=200
PID_FILE="./pids.tmp"
: > "$PID_FILE"

cleanup() {
    echo "終了シグナルを受け取りました。MistNet を全て終了します..."
    pkill -9 -f StandaloneLinux64
    exit 1
}

trap cleanup INT TERM

for i in $(seq 1 $NUM_PROCESSES); do
    ./StandaloneLinux64 > /dev/null 2>&1 &  # 標準出力と標準エラーを捨てる
    echo $! >> "$PID_FILE"
    sleep 0.4
done

wait

rm -f "$PID_FILE"

echo "すべてのプロセスが終了しました"
