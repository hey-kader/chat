local socket = require "socket"
local address, port = "66.85.133.188", 8888

udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(0)

print ("name: ")
name = io.read("*l")

message = ""
function love.keypressed(key)
  if key == 'return' then
    udp:send(message)
    message = ""
  elseif key == 'space' then
    message = message.." "
  elseif key == 'backspace' then
    message = message:sub(1, -2)
  else 
    message = message..key
  end
end

function love.update ()
  udp:send(name.." ".."auth")
	if data then
		data = udp:receive()
	end
end

function love.draw ()
  if data then
    love.graphics.setColor(color)
    love.graphics.print(name..": "..message) 
    love.graphics.setColor({1,0,0,1})
    love.graphics.print(data, 0, 16) 
  end
end
