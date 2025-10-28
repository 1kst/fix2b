#!/bin/bash

# --- 配置 ---
# set -e: 确保脚本在任何命令执行失败时立即退出
set -e

# --- 自动查找项目目录 ---
BASE_DIR="/www/wwwroot"
PROJECT_ROOT=""

echo "正在 $BASE_DIR 目录中搜索项目..."

# 遍历 /www/wwwroot/ 下的每一个子目录
for dir in "$BASE_DIR"/*/; do
    # 检查是否是一个有效的目录
    if [ ! -d "$dir" ]; then
        continue
    fi

    # 检查是否同时存在这两个关键子目录
    # (基于你脚本中下载的目标路径来判断)
    if [ -d "${dir}app/Http/Controllers/V1/User" ] && [ -d "${dir}app/Services" ]; then
        PROJECT_ROOT="$dir"
        break # 找到第一个匹配的就停止
    fi
done

# 如果没有找到
if [ -z "$PROJECT_ROOT" ]; then
    echo "错误：在 $BASE_DIR 中未找到同时包含 'app/Http/Controllers/V1/User' 和 'app/Services' 的项目目录。" >&2
    exit 1
fi

echo "成功找到项目目录: $PROJECT_ROOT"

# --- 切换到项目目录 ---
cd "$PROJECT_ROOT"
echo "已进入目录: $(pwd)"
echo ""


# --- 文件定义 (使用相对路径) ---
# 定义文件1
URL_1="https://raw.githubusercontent.com/1kst/fix2b/refs/heads/main/OrderController.php"
DEST_1="./app/Http/Controllers/V1/User/OrderController.php"

# 定义文件2
URL_2="https://raw.githubusercontent.com/1kst/fix2b/refs/heads/main/PaymentService.php"
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

