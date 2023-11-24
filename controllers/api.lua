local lapis = require("lapis")
local models = require("models")
local UserKeys = models.UserKeys
local ApiCreds = models.ApiCreds
local app = lapis.Application()

local function validate_token(req)
  local token = req.headers["Authorization"]
  if not token then
    return { status = 401, json = { error = "No token provided" } }
  end

  local cred = ApiCreds:find({ token = token })
  if not cred then
    return { status = 401, json = { error = "Invalid token" } }
  end

  req.current_user = cred
end

app:before_filter(validate_token)

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
