local lapis = require("lapis")
local api = require("controllers.api")
local auth = require("controllers.auth")
local manage_keys = require("controllers.manage_keys")

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:include(api)
app:include(auth)
app:include(manage_keys)

return app