local lapis = require("lapis")
local bcrypt = require("bcrypt")
local models = require("models")
local AuthUser = models.AuthUser
local app = lapis.Application()

app:enable("etlua")  -- Enable etlua templating
app.layout = require "views.layout"  -- Assuming you have a base layout

-- Login endpoint
app:match("/login", function(self)
  if self.req.method == "POST" then
    local user = AuthUser:find { username = self.params.username }
    if user and bcrypt.verify(self.params.password, user.password_hash) then
      -- Set user session
      self.session.current_user = user.id
      self.session.current_username = user.username

      -- Set a secure cookie on the client
      self.cookies:set("user_session", self.session.current_user, {
        http_only = true,
        secure = true,  -- Set to false if not using HTTPS
        expires = os.time() + 3600 * 24 * 30  -- Expires in 30 days
      })

      return { redirect_to = "/secure_page" }  -- Redirect to a secure page
    else
      self.session.current_user = nil
      return { render = "login", error = "Invalid username or password" }
    end
  end

  return { render = "login" }
end)

-- Logout endpoint
app:get("/logout", function(self)
  self.session.current_user = nil
  self.cookies:set("user_session", nil)  -- Clear the cookie
  return { redirect_to = "/" }
end)

return app