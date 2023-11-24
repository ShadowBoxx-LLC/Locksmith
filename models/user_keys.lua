local Model = require("lapis.db.model").Model

-- Model for SSH keys
local UserKeys = Model:extend("user_keys", {
  fields = {
    id = { type = "id", primary_key = true },
    username = { type = "text" },
    pubkey = { type = "text" }
  }
})

-- Add a new SSH key for a user
function UserKeys:add_key(username, pubkey)
  return self:create {
    username = username,
    pubkey = pubkey
  }
end

-- Get all SSH keys for a specific user
function UserKeys:get_keys(username)
  return self:select("WHERE username = ?", username)
end

return UserKeys
