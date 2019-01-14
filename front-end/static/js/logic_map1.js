// Creating map object
var myMap = L.map('map1', {
  center: [39.8283, -98.5795],
  zoom: 4
});

// Adding tile layer
L.tileLayer(
  'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}',
  {
    attribution:
      'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox.light',
    accessToken: API_KEY
  }
).addTo(myMap);

// Link to GeoJSON
// var APILink = "http://data.beta.nyc//dataset/d6ffa9a4-c598-4b18-8caf-14abde6a5755/resource/74cdcc33-512f-439c-" +
// "a43e-c09588c4b391/download/60dbe69bcd3640d5bedde86d69ba7666geojsonmedianhouseholdincomecensustract.geojson";

var APILink = '/cb_2017_us_cd115_20m.json';

var geojson;

// Grab data with d3
d3.json(APILink, function(data) {
  // Create a new choropleth layer
  geojson = L.choropleth(data, {
    // Define what  property in the features to use
    valueProperty: 'CD115FP',

    // Set color scale
    scale: ['#ffffff', '#6a0016'],

    // Number of breaks in step range
    steps: 10,

    // q for quartile, e for equidistant, k for k-means
    mode: 'q',
    style: {
      // Border color
      color: '#fff',
      weight: 0.8,
      fillOpacity: 0.8
    },

    // Binding a pop-up to each layer
    onEachFeature: function(feature, layer) {
      layer.bindPopup(
        feature.properties.STATEFP + ', ' + feature.properties.CD115FP
      );
    }
  }).addTo(myMap);

  // Set up the legend
  var legend = L.control({ position: 'bottomright' });
  legend.onAdd = function() {
    var div = L.DomUtil.create('div', 'info legend');
    var limits = geojson.options.limits;
    var colors = geojson.options.colors;
    var labels = [];

    // Add min & max
    var legendInfo =
      '<h6>Employment</h6>' +
      '<div class="labels">' +
      '<div class="min">' +
      limits[0] +
      '</div>' +
      '<div class="max">' +
      limits[limits.length - 1] +
      '</div>' +
      '</div>';

    div.innerHTML = legendInfo;

    limits.forEach(function(limit, index) {
      labels.push('<li style="background-color: ' + colors[index] + '"></li>');
    });

    div.innerHTML += '<ul>' + labels.join('') + '</ul>';
    return div;
  };

  // Adding legend to the map
  legend.addTo(myMap);
});
