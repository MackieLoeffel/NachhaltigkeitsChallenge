passport = require('passport')
LocalStrategy = require('passport-local').Strategy
module.exports = express: customMiddleware: (app) ->
  console.log 'Express midleware for passport'
  app.use passport.initialize()
  app.use passport.session()
  return
