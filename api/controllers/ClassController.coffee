module.exports =
  create: (req, res) ->
    console.log req.params.all()
    Class.create(
      name: req.param("name")
      points: req.param("points")
    ).then(console.log)

  status: (req, res) ->
    Class.find().then (classes) ->
      classes.push
        name: "5B"
        points: 90
      console.log classes
      res.view "homepage", {classes}
    
