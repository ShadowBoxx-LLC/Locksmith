local lapis = require("lapis")
local bcrypt = require("bcrypt")
local models = require("models")
local AuthUser = models.AuthUser
local app = lapis.Application()

app:enable("etlua")

app:match("/login", function(self)
  if self.session.current_user then
    return { redirect_to = "/" }
  end

  if self.req.method == "POST" then
    local user = AuthUser:find { username = self.params.username }
    if user and bcrypt.verify(self.params.password, user.password_hash) then
      self.session.current_user = user.id
      self.session.current_username = user.username
      self.cookies:set("user_session", self.session.current_user, {
        http_only = true,
        secure = true,
        expires = os.time() + 3600 * 24 * 30
      })

      return { redirect_to = "/" }
    else
      return { render = "login", error = "Invalid username or password" }
    end
  end

  return { render = "login" }
end)

app:get("/logout", function(self)
  self.session.current_user = nil
  self.cookies:set("user_session", nil)
  return { redirect_to = "/" }
end)

return app