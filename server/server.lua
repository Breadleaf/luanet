local website = require("index"):toString()

local lapis = require("lapis")

local app = lapis.Application()

app:get("/", function()
    return website
end)

lapis.serve(app)