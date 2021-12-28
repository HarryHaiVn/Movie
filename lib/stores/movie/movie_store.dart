import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/movie/movie_playing_response.dart';
import 'package:boilerplate/models/movie/top_rate_response.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _MovieStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<TopRateResponse?> emptyMovieResponse =
      ObservableFuture.value(null);

  static ObservableFuture<List<Movie>?> emptyMovieFilterResponse =
      ObservableFuture.value(null);

 static ObservableFuture<MoviePlayingResponse?> emptyMoviePlayingResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<TopRateResponse?> fetchMoviesFuture =
      ObservableFuture<TopRateResponse?>(emptyMovieResponse);

  @observable
  ObservableFuture<List<Movie>?> filterMoviesFuture =
      ObservableFuture<List<Movie>?>(emptyMovieFilterResponse);

  @observable
  ObservableFuture<MoviePlayingResponse?> moviePlayingFuture =
      ObservableFuture<MoviePlayingResponse?>(emptyMoviePlayingResponse);

  @observable
  List<Movie>? movieList = List.empty();

  @observable
  List<Movie>? moviePlayingList = List.empty();

  @observable
  bool success = false;

  @computed
  bool get loading => fetchMoviesFuture.status == FutureStatus.pending;

  @computed
  bool get filtered => filterMoviesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getTopRateMovie() async {
    final future = _repository.getTopRateMovie();
    fetchMoviesFuture = ObservableFuture(future);

    future.then((response) {
      this.movieList = response.results;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future filterTopRateMovie(int mixYear, int maxYear) async {
    final future = _repository.filterTopRateMovie(mixYear, maxYear);
    filterMoviesFuture = ObservableFuture(future);

    future.then((response) {
      this.movieList = response;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getMoviePlaying() async {
    final future = _repository.getMoviePlaying();
    moviePlayingFuture = ObservableFuture(future);

    future.then((response) {
      this.moviePlayingList = response.results;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future<dynamic> getKeyYouTubeMovie(int movieId) async {
    final future = _repository.getKeyYouTubeMovie(movieId);
    future.then((response) {
      if (response.results!.isNotEmpty) {
        var keyYouTobe= response.results![0].key ?? "";
        launch("${Endpoints.baseUrlYoutube}$keyYouTobe");
        throw 'Could not launch ${Endpoints.baseUrlYoutube}$keyYouTobe';
      } else {
        errorStore.errorMessage = "Trailer not release";
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
