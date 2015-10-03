passport = require('passport')
module.exports =
  login: (req, res) ->
    res.view()
    return
  process: (req, res) ->
    passport.authenticate('local', (err, user, info) ->
      return res.send message: 'login failed' if err or !user
      req.logIn user, (err) ->
        res.send err if err
        res.send message: 'login successful'
      return
    ) req, res
    return
  logout: (req, res) ->
    req.logout()
    res.send 'logout successful'
    return

module.exports.blueprints =
  actions: true
  rest: true
  shortcuts: true
