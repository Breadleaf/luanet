local luanet = package.loadlib("./libluanet.so", "luaopen_luanet")

if not luanet then
	error("Could not load library")
else
	luanet()
end

local lib = {}
lib.respond = {}
lib.respond.lon = {}
lib.respond.lon.file = {}

function lib.respond.plaintext(text)
	respond_plaintext(text)
end

function lib.respond.lon.text(text)
	respond_lon_text(text)
end

function lib.respond.lon.file.static(file_path)
	respond_lon_file(file_path)
end

function lib.respond.lon.file.dynamic(file_path)
	local file = io.open(file_path, "r")
	local content = file:read("*a")
	file:close()

	if #content == 0 then
		content = "return \"{}\""
	end

	local func, err = load(content)
	if not func then
		respond_plaintext("Error: " .. err)
		return
	end

	local data = func()
	respond_lon_text(data)
end

return lib
