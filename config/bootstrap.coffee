module.exports.bootstrap = (cb) ->
  SolvedChallenge.destroy().then ->
    Class.destroy()
  .then ->
    Challenge.destroy()
  .then ->
    Challenge.create [
      {name: "C1", points: 50}
      {name: "C2", points: 25}
    ]
  .then ([{id: id1}, {id: id2}]) ->
    SolvedChallenge.create [
      {at: new Date().toISOString(), challenge: id1}
      {at: new Date().toISOString(), challenge: id1}
      {at: new Date().toISOString(), challenge: id2}
    ]
  .then ([{id: id1}, {id: id2}, {id: id3}]) ->
    Class.create [
      {name: "6A", challenges: [id1, id2]}
      {name: "5B", challenges: [id3]}
    ]
  .then ->
    Class.find().populate "challenges"
  .then (d) ->
    console.log d
    #console.log d[0].challenges[0].populate("class")
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
