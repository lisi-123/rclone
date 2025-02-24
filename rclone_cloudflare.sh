#!/bin/bash

# 检查用户权限，确保脚本以 root 权限执行
if [ "$(id -u)" -ne "0" ]; then
    echo "请使用 root 权限执行此脚本！"
    exit 1
fi

# 安装 rclone
echo "正在安装 rclone..."
curl https://rclone.org/install.sh | bash

# 提示输入 Cloudflare R2 相关信息
read -p "请输入 Cloudflare R2 的访问密钥 ID（Access Key ID）: " access_key_id
read -sp "请输入 Cloudflare R2 的机密访问密钥（Secret Access Key）: " secret_access_key
echo
read -p "请输入 Cloudflare R2 的终结点（Endpoint），例如 https://<account_id>.r2.cloudflarestorage.com : " endpoint

# 使用 rclone 配置 Cloudflare R2
echo "正在配置 rclone 与 Cloudflare R2 对接..."

rclone config create beifen s3 \
    provider "Cloudflare" \
    access_key_id "$access_key_id" \
    secret_access_key "$secret_access_key" \
    region "auto" \
    endpoint "$endpoint" \
    --config "/root/.config/rclone/rclone.conf"

# 输出配置是否成功
if [ $? -eq 0 ]; then
    echo "rclone 配置成功！"
else
    echo "rclone 配置失败，请检查输入是否正确。"
    exit 1
fi

# 提示用户配置已完成
echo "Cloudflare R2 配置已完成，远程名为 'beifen'，可以使用 rclone 命令操作。"
