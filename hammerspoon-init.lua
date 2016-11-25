pressBackspace = function()
  hs.eventtap.keyStroke({}, "forwarddelete")
end

pressPipeline = function()
  hs.eventtap.keyStroke({'shift'}, '\\')
end

pressDown = function()
  hs.eventtap.keyStroke({}, 'down')
end

pressUp = function()
  hs.eventtap.keyStroke({}, 'up')
end

pressLeft = function()
  hs.eventtap.keyStroke({}, 'left')
end

pressRight = function()
  hs.eventtap.keyStroke({}, 'right')
end

pressVeryDown = function()
  hs.eventtap.keyStroke({'cmd'}, 'down')
end

pressVeryUp = function()
  hs.eventtap.keyStroke({'cmd'}, 'up')
end

pressVeryLeft = function()
  hs.eventtap.keyStroke({'cmd'}, 'left')
end

pressVeryRight = function()
  hs.eventtap.keyStroke({'cmd'}, 'right')
end

hs.hotkey.bind({'ctrl'}, 'delete', pressBackspace)
hs.hotkey.bind({'shift'}, 'delete', pressPipeline)
hs.hotkey.bind({'option'}, 'j', pressDown, nil, pressDown)
hs.hotkey.bind({'option'}, 'k', pressUp, nil, pressUp)
hs.hotkey.bind({'option'}, 'h', pressLeft, nil, pressLeft)
hs.hotkey.bind({'option'}, 'l', pressRight, nil, pressRight)
hs.hotkey.bind({'cmd', 'option'}, 'j', pressVeryDown)
hs.hotkey.bind({'cmd', 'option'}, 'k', pressVeryUp)
hs.hotkey.bind({'cmd', 'option'}, 'h', pressVeryLeft)
hs.hotkey.bind({'cmd', 'option'}, 'l', pressVeryRight)
