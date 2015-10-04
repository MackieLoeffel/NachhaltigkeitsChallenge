passport = require('passport')
module.exports =
  login: (req, res) ->
    res.view()
    return
  process: (req, res) ->
    passport.authenticate('local', (err, user, info) ->
      return res.send message: 'login failed' if err or !user
      req.login user, (err) ->
        if err
          console.log "Error login: ", err
          return res.serverError()

        # TODO: redirect somewhere useful?
        res.redirect '/'
      return
    ) req, res
    return
  logout: (req, res) ->
    req.logout()
    res.redirect '/'
    return

# TODO: useful?
module.exports.blueprints =
  actions: true
  rest: true
  shortcuts: true
