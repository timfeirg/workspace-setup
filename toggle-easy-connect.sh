#!/usr/bin/env bash
set -uo pipefail
IFS=$'\n\t'

# I just fucking hate EasyMonitor

easymonitor_pid=`pgrep EasyMonitor`
if test -z "$easymonitor_pid"
then
  sudo launchctl load /Library/LaunchDaemons/com.sangfor.EasyMonitor.plist
  open /Applications/EasyConnect.app
  echo "time to eat some shit, baby"
else
  sudo pkill EasyConnect
  sudo launchctl unload /Library/LaunchDaemons/com.sangfor.EasyMonitor.plist
  sudo launchctl remove com.sangfor.ECAgentProxy
  echo "everything's fine now"
fi
