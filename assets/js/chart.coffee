ctx = document.getElementById("chart").getContext("2d");
classes = [
  {
    name: "6A",
    points: 50
  }
  {
    name: "7A",
    points: 100
  }
]
     
data = {
  labels: _.map(classes, "name")
  datasets: [
    {
      label: "Punkte",
      fillColor: "rgba(11,20,220,0.2)",
      strokeColor: "rgba(220,98,220,1)",
      pointColor: "rgba(220,220,220,1)",
      pointStrokeColor: "#fff",
      pointHighlightFill: "#fff",
      pointHighlightStroke: "rgba(220,220,220,1)",
      data: _.map(classes, "points")
    }
  ]
}
new Chart(ctx).Bar(data, {});
