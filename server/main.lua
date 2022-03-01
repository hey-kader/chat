socket = require "socket"
udp = socket.udp()
udp:setsockname("*", 12345)
udp:settimeout(0)

message = ""
name = "kader"

function love.keypressed (key)
  if key == 'return' then
    print (message)
    message = ""
  elseif key == 'backspace' then
      message = message:sub(1, -2)
  elseif key == 'space' then
    message = message.." "
  else
    message = message..key
  end
end

function love.update () 
  data, msg_or_ip, port_or_nil = udp:receivefrom()
  if data then
    udp:sendto(name..": "..message, msg_or_ip, port_or_nil)
  end
end

function love.draw () 
  love.graphics.setColor({1, 0, 0, 1})
  love.graphics.print(name..": "..message.."\n")
  love.graphics.setColor({0, 1, 0, 1})
  if data then
    love.graphics.print(data, 0, 16)
  end
end
