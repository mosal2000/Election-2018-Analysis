// Creating map object
var map = L.map("map", {
  center: [39.8283, -98.5795],
  zoom: 5
});

// Adding tile layer
L.tileLayer("https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}", {
  attribution: "Map data &copy; <a href=\"https://www.openstreetmap.org/\">OpenStreetMap</a> contributors, <a href=\"https://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"https://www.mapbox.com/\">Mapbox</a>",
  maxZoom: 10,
  id: "mapbox.light",
  accessToken: API_KEY
}).addTo(map);

var link = ("/cb_2017_us_cd115_20m.json")
// Function that will determine the color of a disrict based on 
function chooseColor(CD115FP) {
  switch (CD115FP) {
  case "11":
    return "red";
  case "24":
    return "blue";
  case "25":
    return "green";
  }
}

// Grabbing our GeoJSON data..
d3.json(link, function(data) {
  // Creating a geoJSON layer with the retrieved data
  L.geoJson(data, {
    // Style each feature (in this case a neighborhood)
    style: function(feature) {
      return {
        color: "black",
        // Call the chooseColor function to decide which color to color our neighborhood (color based on borough)
        fillColor: chooseColor(feature.properties.CD115FP),
        fillOpacity: 0.4,
        weight: 1.5
      };
    }
  }).addTo(map);
});