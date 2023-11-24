local Model = require("lapis.db.model").Model

-- Model for API credentials
local ApiCreds = Model:extend("api_creds", {
  fields = {
    id = { type = "id", primary_key = true },
    username = { type = "text", unique = true },
    token = { type = "text" }
  }
})

-- Generate and store an authentication token for a user
function ApiCreds:generate_token()
  -- Simple random token for demonstration; use a more secure method in production
  local token = tostring(math.random())
  self:update({ token = token })
  return token
end

return ApiCreds
