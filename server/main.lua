local socket = require "socket" 

ip = "*"
port = 8888

udp = socket:udp()
udp:settimeout(0)
udp:setsockname(ip, port)

whitelist = {}
online = {}

function read_file ()
	local file = io.open("whitelist.txt", "rb")
	local content = file:read("*a")
	content = split(content, "\n")
	file:close()	
	return content 
end

function update()
	whitelist = read_file()
end

function auth (user)
	for i in ipairs(whitelist) do
		if whitelist[i] == user then
			return true
		end
	end
	return false
end

function split (content, delimiter)
	local list = {}
	for match in (content..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(list, match)
	end
	return list
end

print ("serving on: " .. ip .. ":" .. port)

repeat 
	update()	
	data, msg_or_ip, port_or_nil = udp:receivefrom()
	if data then
		local msg = split(data, " ")
		user, cmd = msg[1], msg[2]
		if cmd == "auth" then
			if auth(user) then
				local ip = msg_or_ip
				local port = port_or_nil
				print (ip, port)
				table.insert(online, user)
				udp:sendto("success", msg_or_ip, port_or_nil)
			end
		end
	end
until not true 
