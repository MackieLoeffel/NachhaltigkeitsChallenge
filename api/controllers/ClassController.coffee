async = require 'async'

# number of days for point history
numDays = 5

module.exports =
  create: (req, res) ->
    console.log req.params.all()
    Class.create(
      name: req.param("name")
      points: req.param("points")
    ).then(console.log)

  status: (req, res) ->
    # TODO: better error handling
    Class.find().populate("challenges").then (classes) ->
      async.eachSeries classes, (c, cb) ->
        # populate challenges with data of real challenges
        # behind the solved challenges
        async.eachSeries c.challenges, (solved, cb2) ->
          Challenge.findOne({id: solved.challenge}).then (cha) ->
            _.assign solved, cha
            do cb2
          .catch (err) ->
            console.log "Error:", err
        , (err) ->
          console.log err if err?
          do cb
      , (err) ->
          console.log err if err?
          forClient = for c in classes
            c.challenges = _.sortBy(c.challenges, "at")
            
            milliPerDay = 24 * 3600 * 1000
            endDate = Date.now()
            curDate = endDate - milliPerDay * numDays
            points = 0
            history = []
            # console.log c.name, ":"
            for challenge in c.challenges.concat {points: 0, at: new Date(endDate)}
              # console.log "at:", challenge.at, ", curDate:", new Date(curDate), ", points:", points, ", history:", history
              while challenge.at.getTime() >= curDate
                history.push points
                curDate += milliPerDay
              points += challenge.points

            console.assert history.length == numDays + 1, "history should have exactly #{numDays} + 1 entries!"
            {name: c.name, points: history}
          console.log forClient
          
          res.view "homepage", {classes: forClient}
      
