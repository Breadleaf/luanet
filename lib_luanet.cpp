#include <lua.hpp>

#include <iostream>
#include <fstream>
#include <string>
#include <map>

static int luanet_respond_plaintext(lua_State* L)
{
	std::string message(luaL_checkstring(L, 1));
	std::string response = "";
	response += "LUANET 1.0 200 OK\n";
	response += "CONTENT " + std::to_string(message.size()) + " PLAINTEXT\n\n";
	response += message;
	std::cout << response << std::endl;
	return 0;
}

static int luanet_respond_lon_file(lua_State* L)
{
	const char* file_path = luaL_checkstring(L, 1);

	std::ifstream file(file_path);
	if (!file.is_open())
	{
		std::cerr << "Error: file not found " << file_path << std::endl;
		lua_close(L);
	}

	std::string file_contents(
		(std::istreambuf_iterator<char>(file)),
		(std::istreambuf_iterator<char>())
	);

	file.close();

	// remove the extra newline at the end of the file
	file_contents.pop_back();

	std::string response = "";
	response += "LUANET 1.0 200 OK\n";
	response += "CONTENT " + std::to_string(file_contents.size()) + " LON\n\n";
	response += file_contents;
	std::cout << response << std::endl;
	return 0;
}

static int luanet_respond_lon_text(lua_State* L)
{
	std::string message(luaL_checkstring(L, 1));

	std::string response = "";
	response += "LUANET 1.0 200 OK\n";
	response += "CONTENT " + std::to_string(message.size()) + " LON\n\n";
	response += message;
	std::cout << response << std::endl;
	return 0;
}

static int luanet_request_get(lua_State* L)
{
	const char* url = luaL_checkstring(L, 1);
	std::string response = "";
	response += "LUANET 1.0 GET " + std::string(url);
	lua_pushstring(L, response.c_str());
	return 1;
}

static int luanet_request_post(lua_State* L)
{
	std::string url(luaL_checkstring(L, 1));
	
	std::map<std::string, std::string> data;
	if (lua_istable(L, 2))
	{
		lua_pushnil(L);
		while (lua_next(L, 2) != 0)
		{
			// uses 'key' (at index -2) and 'value' (at index -1)
			std::string key(lua_tostring(L, -2));
			std::string value(lua_tostring(L, -1));
			data[key] = value;
			// removes 'value'; keeps 'key' for next iteration
			lua_pop(L, 1);
		}
	}
	else
	{
		std::cerr << "Error: second argument must be a table" << std::endl;
		lua_close(L);
	}

	std::string response = "";
	response += "LUANET 1.0 POST " + url + "\n";
	for (auto& pair : data) response += pair.first + "=" + pair.second + "&";
	response.pop_back();
	lua_pushstring(L, response.c_str());

	return 1;
}

extern "C" int luaopen_luanet(lua_State* L)
{
	// Server functions
	lua_register(L, "respond_plaintext", luanet_respond_plaintext);
	lua_register(L, "respond_lon_file", luanet_respond_lon_file);
	lua_register(L, "respond_lon_text", luanet_respond_lon_text);

	// Client functions
	lua_register(L, "request_get", luanet_request_get);
	lua_register(L, "request_post", luanet_request_post);
	
	return 0;
}
