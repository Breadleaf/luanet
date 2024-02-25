local LON = require("utility.LON")

if #arg < 1 then
    print("Usage: lua main.lua <filename>")
    os.exit(1)
end

local website = LON.parseFile(arg[1])