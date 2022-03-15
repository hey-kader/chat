local uv = require "luv"
local udp = uv.new_udp()

ip, port = "127.0.0.1", 8880
udp:bind(ip, port)
msg = udp:getsockname()

print ("server running on "..ip .. ":" .. port)
repeat 
	udp:send("hey", ip, port)
until not true
uv.run()
