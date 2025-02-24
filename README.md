## 创建 Cloudflare R2 对象存储 的 API令牌

首先在Cloudflare账号选择左侧栏里的“R2 对象存储”

第一次开通需要绑定信用卡

概述——API——管理API令牌——创建API令牌

权限选择“管理员读和写”，然后创建

创建后自行保存显示的所有内容，之后要用

<br>

## 使用rclone快速对接Cloudflare R2 存储桶

您可以通过以下命令一键下载并执行安装脚本：

```bash
wget -N https://raw.githubusercontent.com/lisi-123/rclone/main/rclone_cloudflare.sh && bash ./rclone_cloudflare.sh

```
根据提示填入创建API令牌展示的内容

<br>

## 添加宝塔计划任务

宝塔面板-计划任务-shell脚本

执行用户选择root（没有则不选），脚本内容填写以下内容，“数据库名称”改为自己的数据库名称，执行周期自选

```bash
rclone sync /www/backup/database/mysql/crontab_backup/数据库名称/ beifen:/backup --progress
```

理论上来说宝塔面板的数据库备份路径为“/www/backup/database/mysql/crontab_backup/数据库名称/”

建议在宝塔的文件那里打开这个路径验证一下

如果数据库备份文件不在该路径，请自行寻找对应路径并替换

<br>


