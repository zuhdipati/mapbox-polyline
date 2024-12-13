String baseUrl = "https://api.mapbox.com";
String keyMapBox =
    "sk.eyJ1Ijoia2FybG9kZXYiLCJhIjoiY200MHF0ZHBqMjhldzJxcjBpc2VwajYydiJ9.NOueN9Rz45RaByovuIqeNg";

String urlDirections = "$baseUrl/directions/v5/mapbox";
String urlSearch = "$baseUrl/search/searchbox/v1";

String urlDriving(String? position) =>
    "$urlDirections/driving/$position?geometries=geojson&access_token=$keyMapBox";

String urlSearchSuggest(String? q, String? sessionToken) =>
    "$urlSearch/suggest?q=$q?language=id&country=id&session_token=$sessionToken&access_token=$keyMapBox";
String urlRetrieveSuggest(String? id, String? sessionToken) =>
    "$urlSearch/retrieve/$id?session_token=$sessionToken&access_token=$keyMapBox";
