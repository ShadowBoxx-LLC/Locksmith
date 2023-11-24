local lapis = require("lapis")
local UserKeys = require("models").UserKeys
local app = lapis.Application()

app:get("/users", function(self)
  local users = UserKeys:get_unique_users()
  return { json = users }
end)

app:get("/user/:username/keys", function(self)
  local keys = UserKeys:get_keys(self.params.username)
  return { json = { username = self.params.username, keys = keys } }
end)

app:post("/user/add_key", function(self)
  local username = self.params.username
  local pubkey = self.params.pubkey

  local user_key = UserKeys:add_key(username, pubkey)
  return { json = { message = "Key added", user_key = user_key } }
end)

return app