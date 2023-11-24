local lapis = require("lapis")
local api = require("controllers.api")
local auth = require("controllers.auth")

local app = lapis.Application()
app:enable("etlua")
app.layout = require "views.layout"

app:include(api)
app:include(auth)

app:get("/", function(self)
  return { render = "index" }
end)

return app