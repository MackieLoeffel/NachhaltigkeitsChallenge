passport = require('passport')
module.exports =
  login: (req, res) ->
    res.view()
    return
  process: (req, res) ->
    passport.authenticate('local', (err, user, info) ->
      return res.send message: 'login failed' if err or !user
      req.login user, (err) ->
        # TODO: is this the correct thing todo?
        res.send err if err
        res.redirect '/'
      return
    ) req, res
    return
  logout: (req, res) ->
    req.logout()
    res.redirect '/'
    return

module.exports.blueprints =
  actions: true
  rest: true
  shortcuts: true
