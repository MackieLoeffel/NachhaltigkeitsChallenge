ctx = document.getElementById("chart").getContext("2d");
classes = classes.concat [
  {
    name: "6A",
    points: 50
  }
]
     
data = {
  labels: _.map(classes, "name")
  datasets: [
    {
      label: "Punkte",
      strokeColor: "rgba(0,70,224,0.8)",
      fillColor: "rgba(7,108,240,0.6)",
      data: _.map(classes, "points")
    }
  ]
}
new Chart(ctx).Bar(data, {});
