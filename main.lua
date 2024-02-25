local Website = require("server.internet.website")
local Elements = require("server.internet.elements")

local website = Website:new("Todo List")

local luanet = require("luanet_client")
-- local items = luanet.request.get("luanet://localhost:8080/")
local items = {"Item 1", "Item 2", "Item 3"}

local list = Elements.container()
for index, str in ipairs(items) do
	list:append(Elements.text(index .. ". " .. str))
end

website:addPage("home", {
	list
})

return website:toString()
