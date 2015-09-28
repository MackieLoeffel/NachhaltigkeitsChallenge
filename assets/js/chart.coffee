ctx = document.getElementById("chart").getContext("2d");
     
bar = {
  labels: _.map(classes, "name")
  datasets: [
    {
      label: "Punkte",
      strokeColor: "rgba(0,70,224,0.8)",
      fillColor: "rgba(7,108,240,0.6)",
      data: _.map(classes, "points").map (p) -> p[p.length - 1]
    }
  ]
}
# new Chart(ctx).Bar(bar, {});
if classes.length > 0
  # - 1 for current date
  numdays = classes[0].points.length - 1
  milliPerDay = 24 * 3600 * 1000
  days = ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"]
  line = {
    labels: [-numdays..0].map (i) -> days[new Date(Date.now() + i * milliPerDay).getUTCDay()]
    datasets: for c in classes
      {
        label: c.name
        strokeColor: "rgba(0,70,224,0.8)",
        fillColor: "rgba(7,108,240,0.6)",
        data: c.points
      }
  }
  console.log line
  new Chart(ctx).Line(line, {})
