local Model = require("lapis.db.model").Model

local ApiCreds = Model:extend("api_creds", {
  fields = {
    id = { type = "id", primary_key = true },
    username = { type = "text", unique = true },
    token = { type = "text" }
  }
})

function ApiCreds:generate_token()
  local token = tostring(math.random()) -- Use a secure method in production
  self:update({ token = token })
  return token
end

return ApiCreds
