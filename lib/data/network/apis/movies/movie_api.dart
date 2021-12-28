import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/movie/top_rate_response.dart';
import 'package:boilerplate/models/movie/you_tube_info_response.dart';

class MovieApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  MovieApi(this._dioClient, this._restClient);

  /// Returns list of Top Rate Movie in response
  Future<TopRateResponse> getTopRateMovie() async {
    try {
      final res = await _dioClient.get(Endpoints.getTopRateMovie);
      return TopRateResponse.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns list data of movie in you tube
  Future<YouTubeInfoResponse> getKeyYouTubeMovie(int movieId) async {
    try {
      final url = Endpoints.baseUrlMovie +
          "/" +
          "$movieId" +
          Endpoints.getYouTubeInfo;
      final res = await _dioClient.get(url);
      return YouTubeInfoResponse.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
