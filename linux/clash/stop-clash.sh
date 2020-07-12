#!/bin/bash
# read pid file
cd /etc/clash
PID=`cat clash.pid`
kill -9 ${PID}
rm clash.pid
