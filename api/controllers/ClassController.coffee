async = require 'async'

# number of days for point history
numDays = 5
milliPerDay = 24 * 3600 * 1000

module.exports =
  status: (req, res) ->
    # TODO: better error handling
    Challenge.find().then (challenges) ->
      Class.find().populate("challenges").then (classes) ->
        for c in classes
          for solved in c.challenges
            _.assign solved, _.findWhere(challenges, {id: solved.challenge})
        forClient = for c in classes
          c.challenges = _.sortBy(c.challenges, "at")
          
          endDate = Date.now()
          curDate = endDate - milliPerDay * numDays
          points = 0
          history = []

          for challenge in c.challenges.concat {points: 0, at: new Date(endDate)}
            while challenge.at.getTime() >= curDate
              history.push points
              curDate += milliPerDay
            points += challenge.points
          console.assert history.length == numDays + 1, "history should have exactly #{numDays} + 1 entries!"
          {
            name: c.name
            points: history
            solved: _.map(c.challenges, "challenge")
            id: c.id
          }
        console.log forClient
        
        res.view "homepage",
          classes: forClient
          challenges: challenges.map (c) -> _.pick c, ["name", "points", "id"]
        
      .catch (err) ->
        console.log "Error:", err
    .catch (err) ->
      console.log "Error:", err
      
