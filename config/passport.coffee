passport = require('passport')
LocalStrategy = require('passport-local').Strategy
module.exports =
  express:
    customMiddleware: (app) ->
      app.use passport.initialize()
      app.use passport.session()
      return
