vpnName = 'Tunnelblick'
function appLaunched(appName, eventType, app)
  print("appname:", appName, "app:", app, "eventType:", eventType, "pid: ", app:pid())
  if appName == vpnName and eventType == hs.application.watcher.launched then
    print("tunning on proxy")
    hs.execute('sudo networksetup -setautoproxyurl "Wi-Fi" "http://mirrors.ricebook.net/gfw/auto-switch.pac"')
  elseif eventType == hs.application.watcher.terminated and hs.application.find(vpnName) then
    print("tunning off proxy")
    hs.execute('sudo networksetup -setautoproxystate "Wi-Fi" off')
  end
end

workApplicationWatcher = hs.application.watcher.new(appLaunched)
workApplicationWatcher:start()
