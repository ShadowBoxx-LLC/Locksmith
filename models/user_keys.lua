local Model = require("lapis.db.model").Model

local UserKeys = Model:extend("user_keys", {
  fields = {
    id = { type = "id", primary_key = true },
    username = { type = "text" },
    pubkey = { type = "text" }
  }
})

function UserKeys:add_key(username, pubkey)
  return self:create {
    username = username,
    pubkey = pubkey
  }
end

function UserKeys:get_keys(username)
  return self:select("WHERE username = ?", username)
end

return UserKeys
