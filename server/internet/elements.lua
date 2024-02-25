local Elements = {}

local Element = {}
Element.__index = Element

function Element:new(type, content)
    local instance = setmetatable({}, Element)
    instance.type = type
    instance.content = content
    return instance
end

function Element:toString(indentLevel)
    prettyPrint = indentLevel or false
    indentLevel = indentLevel or 0

    local str = ""

    if prettyPrint then
        local indent = string.rep("\t", indentLevel)
        str = str .. indent .. "{\n"
        str = str .. indent .. "\ttype = \"" .. self.type .. "\",\n"

        if type(self.content) == "table" then
            str = str .. indent .. "\tcontent = {\n"

            for _, element in ipairs(self.content) do
                str = str .. element:toString(indentLevel + 2)
            end

            str = str .. indent .. "\t},\n"
        else
            str = str .. indent .. "\tcontent = \"" .. (self.content or "") .. "\",\n"
        end

        str = str .. indent .. "},\n"
    else
        str = str .. "{"
        str = str .. "type=\"" .. self.type .. "\","

        if type(self.content) == "table" then
            str = str .. "content={"

            for _, element in ipairs(self.content) do
                str = str .. element:toString()
            end

            str = str .. "},"
        else
            str = str .. "content=\"" .. (self.content or "") .. "\","
        end

        str = str .. "},"
    end
    
    return str
end

local Text = setmetatable({}, {__index = Element})

function Text:new(content)
    return Element.new(self, "text", content)
end

local Container = setmetatable({}, {__index = Element})

function Container:new(content)
    content = content or {}
    local instance = Element.new(self, "container", content)
    setmetatable(instance, {__index = self})
    return instance
end

function Container:append(element)
    table.insert(self.content, element)
    -- self.content[#self.content + 1] = element
end

function Elements.text(content)
    return Text:new(content)
end

function Elements.container(content)
    return Container:new(content)
end

return Elements