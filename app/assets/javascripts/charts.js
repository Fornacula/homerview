function drawYearSummary() {
  // Define the chart to be drawn.
  var data = new google.visualization.arrayToDataTable(gon.data)

  // Instantiate and draw the chart.
  var chart = new google.visualization.AreaChart(document.getElementById('yearSummaryChart'))
  chart.draw(data, gon.options)
}
