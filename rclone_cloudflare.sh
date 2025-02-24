#!/bin/bash

# 检查用户权限，确保脚本以 root 权限执行
if [ "$(id -u)" -ne "0" ]; then
    echo "请使用 root 权限执行此脚本！"
    exit 1
fi

# 安装 rclone
echo "正在安装 rclone..."
curl https://rclone.org/install.sh | sudo bash

# 提示输入 Cloudflare R2 相关信息
while true; do
    read -p "请输入 Cloudflare R2 的访问密钥 ID（Access Key ID）: " access_key_id
    read -p "请输入 Cloudflare R2 的机密访问密钥（Secret Access Key）: " secret_access_key
    echo
    read -p "请输入 Cloudflare R2 的终结点（Endpoint），例如：https://<account_id>.r2.cloudflarestorage.com: " endpoint
    echo

    # 显示输入的结果
    echo "您输入的 Cloudflare R2 配置信息如下"
    echo "访问密钥 ID：$access_key_id"
    echo "机密访问密钥：$secret_access_key"
    echo "终结点：$endpoint"

    # 确认输入是否正确
    read -p "是否确认这些信息正确？(y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        break
    else
        echo "请重新输入信息..."
    fi
done

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
echo "Cloudflare R2 配置已完成，远程名为 'beifen' "
