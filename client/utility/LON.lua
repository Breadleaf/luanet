local LON = {}

function LON.parseString(str)
    return load("return " .. str)()
end

function LON.parseFile(filePath)
    local pageFile = io.open(filePath, "r")
    
    if not pageFile then
        return nil
    end
    
    return LON.parseString(pageFile:read("*a"))
end

return LON