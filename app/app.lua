local lapis = require("lapis")
local api = require("controllers.api")
local auth = require("controllers.auth")
local manage_keys = require("controllers.manage_keys")

local app = lapis.Application()
app:enable("etlua")  -- Enable etlua templating
app.layout = require "views.layout"  -- Global layout

app:get("/", function(self)
  return { render = "index" }
end)

app:include(api)
app:include(auth)
app:include(manage_keys)

return app