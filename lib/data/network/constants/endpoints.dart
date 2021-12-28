class Endpoints {
  Endpoints._();

  // base url youtube
  static const String baseUrlYoutube = "https://www.youtube.com/watch?v=";
  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";
  // base url movie
  static const String baseUrlMovie = "https://api.themoviedb.org/3/movie";

  static const String baseUrlImage = "https://image.tmdb.org/t/p/w500/";
  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // top rated endpoints
  static const String getTopRateMovie = baseUrlMovie + "/top_rated?api_key=b743b8d7b6ef6c0a3bb7d1d1e685d4a5&language=en-US&page=1";
  // top rated endpoints
  static const String getMoviePlaying = baseUrlMovie + "/now_playing?api_key=b743b8d7b6ef6c0a3bb7d1d1e685d4a5&language=en-US&page=1";
  // youTube info endpoints
  static const String getYouTubeInfo = "/videos?api_key=b743b8d7b6ef6c0a3bb7d1d1e685d4a5&language=en-US";
}