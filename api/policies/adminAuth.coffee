module.exports = (req, res, next) ->
  if req.isAuthenticated() && req.user.isAdmin
    next()
  else
    res.redirect '/login'
