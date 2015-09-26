module.exports.bootstrap = (cb) ->
  SolvedChallenge.destroy().then ->
    Class.destroy()
  .then ->
    Challenge.destroy()
  .then ->
    Challenge.create({name: "Test", points: 50})
  .then ({id}) ->
    SolvedChallenge.create({at: new Date().toISOString(), challenge: id})
  .then ({id}) ->
    Class.create({name: "6A", challenges: [id]})
  .then ->
    Class.find().populate "challenges"
  .then (d) ->
    console.log d
    SolvedChallenge.find().populate("challenge")
  .then (s) ->
    console.log s
    Challenge.find()
  .then (c) ->
    console.log c
    cb()
  .catch (err) ->
    console.log "Error: ", err
    cb()
