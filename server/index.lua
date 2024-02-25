local Website = require("internet.website")
local Elements = require("internet.elements")

local website = Website:new("My Website")

local todoList = Elements.container()

local todoListItems = {
    "Add Styles To Lua Net",
    "Add More Elements",
    "Make official website"
}

for index, item in ipairs(todoListItems) do
    todoList:append(Elements.text(index .. ". " .. item))
end

website:addPage("home", {
    Elements.text("Welcome to my website!"),
    Elements.text("Here is a list of things I need to do:"),
    todoList
})

return website