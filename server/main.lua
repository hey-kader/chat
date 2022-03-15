socket = require "socket"
ip, port = "*", 8888

udp = socket.udp() 
udp:setsockname(ip, port)
udp:settimeout(0)

whitelist = {} online = {}

function read_file ()
	local file = io.open("whitelist.txt", "rb")
	local body = file:read("*a")
	body = split(body, "\n")
	file:close()	
	return body 
end

function update()
	whitelist = read_file()
end

function is_online (user)
	for k, v in pairs (online) do
		if user == v then
			return true
		end
	end
	return false
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
	for match in (content .. delimiter):gmatch("(.-)"..delimiter) do
		table.insert(list, match)
	end
	return list
end

repeat 
	update()	
	data, msg_or_ip, port_or_nil = udp:receivefrom()
	if data then
		local msg = split(data, " ")
		user, cmd = msg[1], msg[2]
		if cmd == "auth" then
			if auth(user) then
				if not is_online (user) then
					table.insert(online, user)
					udp:sendto("success", msg_or_ip, port_or_nil)
					local dg = string.format(msg_or_ip .. '    ' .. port_or_nil .. '    ' ..user .. '    ' .. cmd .. '    ' .. '('..os.date("%c")..')')
					print (dg)
					udp:sendto(dg, msg_or_ip, port_or_nil)
				else
					udp:sendto("user already online", msg_or_ip, port_or_nil)
				end
			end
		end
	end
until not true 
