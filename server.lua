local luanet = require("luanet_server")

--[[
luanet.listen.get("/", function()
	luanet.respond.lon.file.static("index.lua")
end)
]]

print(luanet.respond.lon.file.static("index.lua"))
print(luanet.respond.lon.file.dynamic("main.lua"))
