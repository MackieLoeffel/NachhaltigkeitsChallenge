passport = require('passport')
LocalStrategy = require('passport-local').Strategy
bcrypt = require('bcrypt')

findById = (id, fn) ->
  User.findOne(id).exec (err, user) ->
    if err
      fn null, null
    else
      fn null, user
  return

findByUsername = (u, fn) ->
  User.findOne(name: u).exec (err, user) ->
    # Error handling
    if err
      fn null, null
      # The User was found successfully!
    else
      fn null, user
  return

passport.serializeUser (user, done) ->
  done null, user.id
  return
passport.deserializeUser (id, done) ->
  findById id, (err, user) ->
    done err, user
    return
  return

passport.use new LocalStrategy((username, password, done) ->
  # asynchronous verification, for effect...
  process.nextTick ->

    findByUsername username, (err, user) ->
      if err
        return done(null, err)
      if !user
        return done(null, false, message: 'Unknown user ' + username)
      bcrypt.compare password, user.password, (err, res) ->
        if !res
          return done(null, false, message: 'Invalid Password')
        returnUser = 
          name: user.name
          createdAt: user.createdAt
          id: user.id
        done null, returnUser, message: 'Logged In Successfully'
      return
    return
  return
)

