local Model = require("lapis.db.model").Model
local bcrypt = require("bcrypt")

local ApiCreds = Model:extend("api_creds", {
  fields = {
    id = { type = "id", primary_key = true },
    username = { type = "text", unique = true },
    password_hash = { type = "text" }
  }
})

function ApiCreds:create_user(username, password)
  local password_hash = bcrypt.digest(password, 10)
  return self:create {
    username = username,
    password_hash = password_hash
  }
end

return ApiCreds