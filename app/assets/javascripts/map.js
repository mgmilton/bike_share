$(document).ready(function() {
  L.mapbox.accessToken = map_key;
  var latitude = 39.0;
  var longitude = -97.4;
  var zoomLevel = 5;
  var mapStyle = 'mapbox.streets';

  var map = L.mapbox.map('map')
    .setView([latitude, longitude], zoomLevel)
    .addLayer(L.mapbox.tileLayer(mapStyle));
});
