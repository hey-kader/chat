require "colors"
require "font"

socket = require "socket"
ip, port = "localhost", 8080

udp = socket.udp()
udp:setsockaddr(ip, port)
udp:settimeout(0)

whitelist = {}
online = {}

function read_file ()
	local file = io.open("whitelist.txt", "rb")
	local content = file:read("*a")
	content = split(content, "\n")
	file:close()	
	return content 
end

function love.draw()
	i = 16 
	love.graphics.setColor(blue)
	love.graphics.print("online: ".."("..#online.."/"..#whitelist..")")
	for k, v in ipairs(whitelist) do 
		love.graphics.setColor(white)
		love.graphics.print(v..": ", 0, i)
		i = i + 16
	end
end

function love.update()
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
