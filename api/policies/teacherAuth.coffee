module.exports = (req, res, next) ->
  # User is allowed, proceed to controller
  is_auth = req.isAuthenticated()
  if is_auth
    next()
  else
    res.redirect '/login'
