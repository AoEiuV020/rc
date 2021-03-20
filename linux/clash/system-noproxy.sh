#!/bin/bash
echo disable system proxy...
unset ALL_PROXY
unset FTP_PROXY
unset HTTPS_PROXY
unset HTTP_PROXY
unset NO_PROXY
unset all_proxy
unset ftp_proxy
unset http_proxy
unset https_proxy
unset no_proxy
which dconf &>/dev/null && (
dconf write /system/proxy/mode "'none'"
) || true
