#!/bin/bash

# --- 配置 ---
# set -e: 确保脚本在任何命令执行失败时立即退出
set -e

# 定义文件1
URL_1="https://raw.githubusercontent.com/1kst/fix2b/refs/heads/main/OrderController.php"
DEST_1="./app/Http/Controllers/V1/User/OrderController.php"

# 定义文件2
URL_2="https://raw.githubusercontent.com/1kst/fix2b/refs/heads/main/PaymentService.php"
# 注意：您的原始请求中，第二个路径为 /app/ServicesPaymentService.php
# 这里假设您的意思是 ./app/Services/PaymentService.php
DEST_2="./app/Services/PaymentService.php"


# --- 执行 ---

echo "开始更新文件..."

# 1. 处理 OrderController
echo "[1/2] 正在下载 OrderController..."
# 确保目标目录存在，-p 表示如果不存在则创建
mkdir -p "$(dirname "$DEST_1")"
# 下载文件并覆盖
# -L: 跟随重定向
# -f: 在服务器错误时不显示内容
# -s: 静默模式
# -S: 配合-s，但在失败时显示错误
# -o: 指定输出文件
curl -LfsS "$URL_1" -o "$DEST_1"
echo "OrderController.php 已覆盖。"


# 2. 处理 PaymentService
echo "[2/2] 正在下载 PaymentService..."
# 确保目标目录存在
mkdir -p "$(dirname "$DEST_2")"
# 下载文件并覆盖
curl -LfsS "$URL_2" -o "$DEST_2"
echo "PaymentService.php 已覆盖。"

echo ""
echo "所有文件均已成功更新！"
