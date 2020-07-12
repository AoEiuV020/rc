#!/bin/bash
echo disable system proxy...
HOME=$(eval echo ~$USER)
export DISPLAY=:0
export XDG_RUNTIME_DIR="/run/user/$UID"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$UID/bus"
dconf write /system/proxy/mode "'none'"
