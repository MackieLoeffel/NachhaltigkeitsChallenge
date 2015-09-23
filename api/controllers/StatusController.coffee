module.exports =
  status: (req, res) ->
    Class.find().then (classes) ->
      classes.push
        name: "5B"
        points: 90
      console.log classes
      res.view "homepage", {classes}
    
