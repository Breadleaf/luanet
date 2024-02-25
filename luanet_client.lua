local luanet = package.loadlib("./libluanet.so", "luaopen_luanet")

if not luanet then
	error("Could not load library")
else
	luanet()
end

local lib = {}
lib.request = {}

function lib.request.get(url)
	return request_get(url)
end

function lib.request.post(url, data)
	return request_post(url, data)
end

return lib
