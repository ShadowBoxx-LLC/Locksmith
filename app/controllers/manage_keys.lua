local lapis = require("lapis")
local UserKeys = require("models").UserKeys
local app = lapis.Application()

local function require_login(self)
  if not self.session.current_user then
    return { redirect_to = "/login" }
  end
end

app:get("/manage_keys", require_login, function(self)
  self.user_keys = UserKeys:select()  -- Fetch all keys
  return { render = "manage_keys" }
end)

app:post("/delete_keys", require_login, function(self)
  for _, key_id in ipairs(self.params.key_ids or {}) do
    local key = UserKeys:find(key_id)
    if key then
      key:delete()
    end
  end
  return { redirect_to = "/manage_keys" }
end)

app:get("/add_key", require_login, function(self)
  return { render = "add_key" }
end)

app:post("/add_key", require_login, function(self)
  local username, pubkey = self.params.username, self.params.pubkey
  if not username or not pubkey then
    return { render = "add_key", error = "Both username and public key are required." }
  end

  UserKeys:add_key(username, pubkey)
  return { redirect_to = "/manage_keys" }
end)

return app