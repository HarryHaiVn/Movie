import 'dart:async';

import 'package:boilerplate/data/local/datasources/movie/movie_datasource.dart';
import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/movie/movie_playing_response.dart';
import 'package:boilerplate/models/movie/movie_up_coming_response.dart';
import 'package:boilerplate/models/movie/top_rate_response.dart';
import 'package:boilerplate/models/movie/you_tube_info_response.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:sembast/sembast.dart';

import 'local/constants/db_constants.dart';
import 'network/apis/movies/movie_api.dart';
import 'network/apis/posts/post_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;
  final MovieDataSource _movieDataSource;

  // api objects
  final PostApi _postApi;

  // api objects
  final MovieApi _getApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._sharedPrefsHelper, this._postDataSource,
      this._getApi, this._movieDataSource);

  // Top Rate Movie: ---------------------------------------------------------------------
  Future<TopRateResponse> getTopRateMovie() async {
    return await _getApi.getTopRateMovie().then((response) {
      response.results?.forEach((movie) {
        _movieDataSource.updateOrInsert(movie);
      });
      return response;
    }).catchError((error) => throw error);
  }

  Future<MoviePlayingResponse> getMoviePlaying() async {
    return await _getApi.getMoviePlaying().then((response) {
      return response;
    }).catchError((error) => throw error);
  }

  Future<MovieUpComingResponse> getMovieUpcoming() async {
    return await _getApi.getMovieUpcoming().then((response) {
      return response;
    }).catchError((error) => throw error);
  }

  Future<List<Movie>> filterTopRateMovie(int mixYear, int maxYear) async {
    List<Movie> moviesList = <Movie>[];
    return _movieDataSource.getMovieFromDb().then((movies) {
      // movie list filtered
      movies?.forEach((element) {
        var year = Utils.getYear(element.releaseDate ?? "");
        if (mixYear <= year && year <= maxYear) {
          moviesList.add(element);
        }
      });
      return moviesList;
    }).catchError((error){
      throw error;
    });
  }

  Future<YouTubeInfoResponse> getKeyYouTubeMovie(int movieId) async {
    return await _getApi.getKeyYouTubeMovie(movieId).then((response) {
      return response;
    }).catchError((error) => throw error);
  }

  // Post: ---------------------------------------------------------------------
  Future<PostList> getPosts() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postApi.getPosts().then((postsList) {
      postsList.posts?.forEach((post) {
        _postDataSource.insert(post);
      });

      return postsList;
    }).catchError((error) => throw error);
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(Post post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await Future.delayed(Duration(seconds: 2), () => true);
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
