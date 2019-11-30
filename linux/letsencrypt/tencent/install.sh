#!/bin/sh
# 需要安装pip, 
# 依赖环境：Python 2.7 到 3.6 版本
# ubuntu: sudo apt install -y python-pip
set -e
if test "0" -ne "$(id -u)"; then
    echo require root
    exit 1
fi
pip install tencentcloud-sdk-python
