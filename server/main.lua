local socket = require "socket" 

ip = "66.85.133.188"
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

-- returns true if user in users
function auth (user, users)
	for i in #users do
		if users[i] == user then
			return true
		end
	end
	return false
end

-- splits tape into list
function split (content, delimiter)
	list = {}
	for match in (content..delimiter):gmatch("(.-)"..delimiter) do
		if #match > 1 then
			table.insert(list, match)
		end
	end
	return list
end

print ("serving on: " .. ip .. ":" .. port)
repeat 
	update()	
until not true 
