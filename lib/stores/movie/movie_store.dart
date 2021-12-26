import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/gets/top_rate_response.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

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

  @observable
  ObservableFuture<TopRateResponse?> fetchMoviesFuture =
      ObservableFuture<TopRateResponse?>(emptyMovieResponse);

  @observable
  List<Movie>? movieList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchMoviesFuture.status == FutureStatus.pending;

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
}