#!/bin/bash

# 切换到用户主目录
cd ~

# 使用curl下载文件
echo "正在下载fqapi.zip..."
curl -L -O https://raw.githubusercontent.com/Hun-Dun/fqapi/main/src/fqapi.zip

# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo "下载失败，请检查网络连接和URL地址"
    exit 1
fi

# 解压文件
echo "正在解压文件..."
unzip fqapi.zip

# 检查解压是否成功
if [ $? -ne 0 ]; then
    echo "解压失败，请检查文件完整性"
    exit 1
fi

# 给fqapi文件添加执行权限
echo "添加执行权限..."
chmod +x fqapi

# 创建alias快捷指令
echo "创建快捷指令..."
SHELL_CONFIG=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
elif [ -f "$HOME/.bash_profile" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
else
    echo "未找到shell配置文件，将创建 ~/.bashrc"
    SHELL_CONFIG="$HOME/.bashrc"
    touch "$SHELL_CONFIG"
fi

# 检查是否已存在alias
if ! grep -q "alias fqapi=" "$SHELL_CONFIG"; then
    echo "alias fqapi='~/fqapi'" >> "$SHELL_CONFIG"
    echo "已添加alias到 $SHELL_CONFIG"
else
    echo "fqapi alias已存在"
fi

# 使配置立即生效
if [ -n "$SHELL_CONFIG" ]; then
    source "$SHELL_CONFIG"
    echo "配置已立即生效"
fi

# 运行程序
echo "启动fqapi..."
./fqapi