$(document).ready(function() {
  var plug = $(".temperature-chart").attr("class");
  var plugId = plug.substring(23, plug.length);

  $.ajax({
          type: "GET",
          contentType: "application/json; charset=utf-8",
          url: plugId + "/temperature_data",
          dataType: "json",
          success: function(data) {
            drawTemperature(data);
          },
          error: function(result) {
            error();
          }
        });
});

function drawTemperature(data) {
  var margin = {top: 30, right: 30, bottom: 30, left: 40};
  var width = 960 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

  var parseDateTime = d3.timeParse("%Y-%m-%dT%H:%M:%S.%LZ");

  var x = d3.scaleTime().range([0, width]);
  var y = d3.scaleLinear().range([height, 0]);

  var valueline = d3.line()
    .x(function(d) { return x(d.date_time); })
    .y(function(d) { return y(d.temperature); });

  var chart = d3.select(".temperature-chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  data.forEach(function(d) {
    d.date_time = parseDateTime(d.date_time);
    d.temperature = +d.temperature;
  });

  x.domain(d3.extent(data, function(d) { return d.date_time; }));
  y.domain([0, d3.max(data, function(d) { return d.temperature; })]);

  chart.append("path")
    .data([data])
    .attr("class", "line")
    .attr("d", valueline);

  chart.append("g")
    .attr("transform", "translate(0," + height + ")")
    .call(d3.axisBottom(x));

  chart.append("g")
    .call(d3.axisLeft(y));

  chart.append("text")
    .attr("class", "axis-label")
    .attr("transform", "rotate(-90)")
    .attr("y", 0 - margin.left)
    .attr("x", 0 - (height / 2))
    .attr("dy", "1em")
    .style("text-anchor", "middle")
    .text("Temperature");

  chart.append("text")
    .attr("class", "axis-label")
    .style("text-anchor", "middle")
    .attr("y", 370)
    .attr("x", (width / 2))
    .text("Time")

  chart.append("text")
    .attr("class", "chart-title")
    .attr("x", (width / 2))
    .attr("y", 0 - (margin.top / 2))
    .attr("text-anchor", "middle")
    .text("Temperature over Time");
}

function error() {
  console.log("Something went wrong");
}
