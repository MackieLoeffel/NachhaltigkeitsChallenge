module.exports = (req, res, next) ->
  # every logged in User is at least a teacher
  if req.isAuthenticated() && req.user.isAdmin
    next()
  else
    res.redirect '/login'
