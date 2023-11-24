local lapis = require("lapis")
local api = require("controllers.api")
local app = lapis.Application()

app:include(api)
app:get("/", function()
  return "Welcome to Lapis " .. require("lapis.version")
end)

return app
