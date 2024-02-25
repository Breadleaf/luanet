local luanet = require("luanet_client")

local response = luanet.request.post("http://localhost:8080", {
	name = "John",
	age = 30,
	phone = "1234567890"
})

print(response)

response = luanet.request.get("http://localhost:8080")

print(response)
