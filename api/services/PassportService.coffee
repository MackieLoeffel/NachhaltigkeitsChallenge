passport = require('passport')
LocalStrategy = require('passport-local').Strategy
bcrypt = require('bcrypt')

passport.serializeUser (user, done) -> done null, user.id

passport.deserializeUser (id, done) ->
  User.findOne({id}).exec (err, user) -> done err, user?.toJSON()

passport.use new LocalStrategy
  usernameField: 'email'
  passwordField: 'password'
  
  (email, password, done) ->
    errorMessage = "Wrong Credentials!"
    User.findOne({email}).then (user) ->
      return done(null, false, message: errorMessage) if !user
      bcrypt.compare password, user.password, (err, res) ->
        return done(null, false, message: errorMessage) if !res
        done null, user.toJSON(), message: 'Logged In Successfully'
    .catch (err) -> done err

