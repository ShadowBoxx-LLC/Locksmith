local lapis = require("lapis")
local UserKeys = require("models").UserKeys
local app = lapis.Application()

-- Endpoint to render the manage keys page
app:get("/manage_keys", function(self)
  self.user_keys = UserKeys:select()  -- Fetch all keys
  return { render = "manage_keys" }
end)

-- Endpoint to handle key deletion
app:post("/delete_keys", function(self)
  for _, key_id in ipairs(self.params.key_ids or {}) do
    local key = UserKeys:find(key_id)
    if key then
      key:delete()
    end
  end
  return { redirect_to = "/manage_keys" }
end)

-- Endpoint to render the add key page
app:get("/add_key", function(self)
  return { render = "add_key" }
end)

-- Endpoint to handle key addition
app:post("/add_key", function(self)
  local username, pubkey = self.params.username, self.params.pubkey
  if not username or not pubkey then
    return { render = "add_key", error = "Both username and public key are required." }
  end

  UserKeys:add_key(username, pubkey)
  return { redirect_to = "/manage_keys" }  -- Redirect back to the key management page
end)

return app