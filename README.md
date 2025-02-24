# 使用rclone快速对接Cloudflare R2 存储桶

首先在Cloudflare账号开启左侧栏里的“R2 对象存储”

第一次开通需要绑定信用卡

概述——API——管理API令牌——创建API令牌

权限选择“管理员读和写”，然后创建

创建后自行保存显示的所有内容，之后要用

## 一键安装脚本

您可以通过以下命令一键下载并执行安装脚本：

```bash
wget -N https://raw.githubusercontent.com/lisi-123/rclone/main/rclone_cloudflare.sh && bash ./rclone_cloudflare.sh

```
根据提示填写创建API令牌展示的内容


宝塔面板-计划任务-shell脚本

执行用户选择root，脚本内容填写以下内容，执行周期自选

```bash
rclone sync /www/backup/database/mysql/crontab_backup/数据库名称/ beifen:/backup --progress
```

理论上来说宝塔面板的数据库备份文件都在“/www/backup/database/mysql/crontab_backup/数据库名称/”这个路径

如果不在，请自行寻找对应路径并更改
