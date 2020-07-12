#!/bin/bash
echo disable system proxy...
HOME=$(eval echo ~$USER)
dbus-launch dconf write /system/proxy/mode "'none'"
