milliPerDay = 24 * 3600 * 1000

module.exports =
  createClass: (req, res) ->
    console.log "params:", req.params.all()
    Class.create
      name: req.param("name")
    .then(console.log).catch((err) -> console.log "Error:", err)

  createChallenge: (req, res) ->
    console.log "params:", req.params.all()
    Challenge.create
      name: req.param("name")
      points: req.param("points")
    .then(console.log).catch((err) -> console.log "Error:", err)

  solveChallenge: (req, res) ->
    console.log "params:", req.params.all()
    solved = req.param("solvedChallenge")
    Challenge.findOne({id: solved}).then (challenge) ->
      console.assert challenge?, "invalid id!"
    .then ->
      Class.findOne({id: req.param("selectedClass")}).populate("challenges")
    .then (c) ->
      console.assert !_.findWhere(c.challenges, {challenge: +solved})?, "already solved!"
      c.challenges.add
        challenge: +solved
        at: new Date(Date.now() - req.param("solvedAt") * milliPerDay).toISOString()
      c.save(console.log)
        
    .catch (err) ->
      console.log "Error:", err
      res.serverError()

  page: (req, res) ->
    res.view()
