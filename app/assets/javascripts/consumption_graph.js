$(document).ready(function() {
  var plug = $(".consumption-chart").attr("class");
  var plugId = plug.substring(23, plug.length);

  $.ajax({
          type: "GET",
          contentType: "application/json; charset=utf-8",
          url: plugId + "/consumption_data",
          dataType: "json",
          success: function(data) {
            drawConsumption(data);
          },
          error: function(result) {
            error();
          }
        });
});

function drawConsumption(data) {
  var margin = {top: 20, right: 30, bottom: 30, left: 40};
  var width = 960 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

  var parseDateTime = d3.timeParse("%Y-%m-%dT%H:%M:%S.%LZ");

  var x = d3.scaleTime().range([0, width]);
  var y = d3.scaleLinear().range([height, 0]);

  var valueline = d3.line()
    .x(function(d) { return x(d.date_time); })
    .y(function(d) { return y(d.consumption); });

  var chart = d3.select(".consumption-chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  data.forEach(function(d) {
    d.date_time = parseDateTime(d.date_time);
    d.consumption = +d.consumption;
  });

  x.domain(d3.extent(data, function(d) { return d.date_time; }));
  y.domain([0, d3.max(data, function(d) { return d.consumption; })]);

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
    .text("Consumption");

  chart.append("text")
    .attr("class", "chart-title")
    .attr("x", (width / 2))
    .attr("y", 0 - (margin.top / 2))
    .attr("text-anchor", "middle")
    .text("Consumption over Time");
}

function error() {
  console.log("Something went wrong");
}
