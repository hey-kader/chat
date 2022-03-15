local socket = require "socket"
local address, port = "kader.international", 8888

udp = socket.udp()
udp:setpeername(address, port)
udp:settimeout(0)
print ("login: ")
name = io.read("*l")
udp:send(name .. " " .. "auth")

repeat
	data = udp:receive() 
until data 

print (data)

repeat
	data = udp:receive()
	if data then
		print (data)
	end
until not true 
