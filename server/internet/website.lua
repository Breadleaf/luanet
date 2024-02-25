local Website = {}
Website.__index = Website

function Website:new(title)
    local instance = setmetatable({}, Website)
    instance.title = title or "Default Title"
    instance.root = nil
    instance.pages = {}
    return instance
end

function Website:addPage(pageName, content)
    if not self.root then
        self.root = pageName
    end

    self.pages[pageName] = content
end

function Website:toString(prettyPrint)
    prettyPrint = prettyPrint or false

    local str = ""

    if prettyPrint then
        str = str .. "{\n"
        str = str .. "\ttitle = \"" .. self.title .. "\",\n"
        str = str .. "\troot = \"" .. (self.root or "") .. "\",\n"
        str = str .. "\tpages = {\n"
    
        for pageName, content in pairs(self.pages) do
            str = str .. "\t\t" .. pageName .. " = {\n"
    
            for _, element in ipairs(content) do
                str = str .. element:toString(3)
            end
    
            str = str .. "\t\t},\n"
        end
    
        str = str .. "\t}\n"
        str = str .. "}\n"
    else
        str = str .. "{"
        str = str .. "title=\"" .. self.title .. "\","
        str = str .. "root=\"" .. (self.root or "") .. "\","
        str = str .. "pages={"
    
        for pageName, content in pairs(self.pages) do
            str = str .. pageName .. "={"
    
            for _, element in ipairs(content) do
                str = str .. element:toString()
            end
    
            str = str .. "},"
        end
    
        str = str .. "}"
        str = str .. "}"
    end

    return str
end

return Website