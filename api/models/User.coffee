# see http://www.geektantra.com/2013/08/implement-passport-js-authentication-with-sails-js/

bcrypt = require('bcrypt')
module.exports =
  attributes:
    name:
      type: 'string'
      required: true
    email:
      type: 'string'
      # email: true
      unique: true
    password:
      type: 'string'
      required: true
    isAdmin:
      type: 'boolean'
      defaultsTo: false
    
    toJSON: ->
      obj = @toObject()
      delete obj.password
      return obj
      
  beforeCreate: (user, cb) ->
    bcrypt.genSalt 10, (err, salt) ->
      bcrypt.hash user.password, salt, (err, hash) ->
        if err
          console.log "Error with bcrypt:", err
          cb err
        else
          user.password = hash
          cb null, user
