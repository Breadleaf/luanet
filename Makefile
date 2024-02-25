compiler = clang++
flags = -fPIC -shared -l lua -l dl -l m -l stdc++
source = lib_luanet.cpp
output = libluanet.so

all:
	$(compiler) $(flags) $(source) -o $(output)

clean:
	rm -f $(output)
