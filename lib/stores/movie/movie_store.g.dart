// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieStore on _MovieStore, Store {
  Computed<bool>? _$loadingTopRateMoviesComputed;

  @override
  bool get loadingTopRateMovies => (_$loadingTopRateMoviesComputed ??=
          Computed<bool>(() => super.loadingTopRateMovies,
              name: '_MovieStore.loadingTopRateMovies'))
      .value;
  Computed<bool>? _$loadingMoviePlayingComputed;

  @override
  bool get loadingMoviePlaying => (_$loadingMoviePlayingComputed ??=
          Computed<bool>(() => super.loadingMoviePlaying,
              name: '_MovieStore.loadingMoviePlaying'))
      .value;
  Computed<bool>? _$loadingMovieUpComingComputed;

  @override
  bool get loadingMovieUpComing => (_$loadingMovieUpComingComputed ??=
          Computed<bool>(() => super.loadingMovieUpComing,
              name: '_MovieStore.loadingMovieUpComing'))
      .value;
  Computed<bool>? _$filteredComputed;

  @override
  bool get filtered => (_$filteredComputed ??=
          Computed<bool>(() => super.filtered, name: '_MovieStore.filtered'))
      .value;

  final _$topRateMoviesFutureAtom =
      Atom(name: '_MovieStore.topRateMoviesFuture');

  @override
  ObservableFuture<TopRateResponse?> get topRateMoviesFuture {
    _$topRateMoviesFutureAtom.reportRead();
    return super.topRateMoviesFuture;
  }

  @override
  set topRateMoviesFuture(ObservableFuture<TopRateResponse?> value) {
    _$topRateMoviesFutureAtom.reportWrite(value, super.topRateMoviesFuture, () {
      super.topRateMoviesFuture = value;
    });
  }

  final _$filterMoviesFutureAtom = Atom(name: '_MovieStore.filterMoviesFuture');

  @override
  ObservableFuture<List<Movie>?> get filterMoviesFuture {
    _$filterMoviesFutureAtom.reportRead();
    return super.filterMoviesFuture;
  }

  @override
  set filterMoviesFuture(ObservableFuture<List<Movie>?> value) {
    _$filterMoviesFutureAtom.reportWrite(value, super.filterMoviesFuture, () {
      super.filterMoviesFuture = value;
    });
  }

  final _$moviePlayingFutureAtom = Atom(name: '_MovieStore.moviePlayingFuture');

  @override
  ObservableFuture<MoviePlayingResponse?> get moviePlayingFuture {
    _$moviePlayingFutureAtom.reportRead();
    return super.moviePlayingFuture;
  }

  @override
  set moviePlayingFuture(ObservableFuture<MoviePlayingResponse?> value) {
    _$moviePlayingFutureAtom.reportWrite(value, super.moviePlayingFuture, () {
      super.moviePlayingFuture = value;
    });
  }

  final _$movieUpComingFutureAtom =
      Atom(name: '_MovieStore.movieUpComingFuture');

  @override
  ObservableFuture<MovieUpComingResponse?> get movieUpComingFuture {
    _$movieUpComingFutureAtom.reportRead();
    return super.movieUpComingFuture;
  }

  @override
  set movieUpComingFuture(ObservableFuture<MovieUpComingResponse?> value) {
    _$movieUpComingFutureAtom.reportWrite(value, super.movieUpComingFuture, () {
      super.movieUpComingFuture = value;
    });
  }

  final _$movieListAtom = Atom(name: '_MovieStore.movieList');

  @override
  List<Movie>? get movieList {
    _$movieListAtom.reportRead();
    return super.movieList;
  }

  @override
  set movieList(List<Movie>? value) {
    _$movieListAtom.reportWrite(value, super.movieList, () {
      super.movieList = value;
    });
  }

  final _$moviePlayingListAtom = Atom(name: '_MovieStore.moviePlayingList');

  @override
  List<Movie>? get moviePlayingList {
    _$moviePlayingListAtom.reportRead();
    return super.moviePlayingList;
  }

  @override
  set moviePlayingList(List<Movie>? value) {
    _$moviePlayingListAtom.reportWrite(value, super.moviePlayingList, () {
      super.moviePlayingList = value;
    });
  }

  final _$movieUpComingListAtom = Atom(name: '_MovieStore.movieUpComingList');

  @override
  List<Movie>? get movieUpComingList {
    _$movieUpComingListAtom.reportRead();
    return super.movieUpComingList;
  }

  @override
  set movieUpComingList(List<Movie>? value) {
    _$movieUpComingListAtom.reportWrite(value, super.movieUpComingList, () {
      super.movieUpComingList = value;
    });
  }

  final _$successAtom = Atom(name: '_MovieStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$getTopRateMovieAsyncAction =
      AsyncAction('_MovieStore.getTopRateMovie');

  @override
  Future<dynamic> getTopRateMovie() {
    return _$getTopRateMovieAsyncAction.run(() => super.getTopRateMovie());
  }

  final _$filterTopRateMovieAsyncAction =
      AsyncAction('_MovieStore.filterTopRateMovie');

  @override
  Future<dynamic> filterTopRateMovie(int mixYear, int maxYear) {
    return _$filterTopRateMovieAsyncAction
        .run(() => super.filterTopRateMovie(mixYear, maxYear));
  }

  final _$getMoviePlayingAsyncAction =
      AsyncAction('_MovieStore.getMoviePlaying');

  @override
  Future<dynamic> getMoviePlaying() {
    return _$getMoviePlayingAsyncAction.run(() => super.getMoviePlaying());
  }

  final _$getMovieUpcomingAsyncAction =
      AsyncAction('_MovieStore.getMovieUpcoming');

  @override
  Future<dynamic> getMovieUpcoming() {
    return _$getMovieUpcomingAsyncAction.run(() => super.getMovieUpcoming());
  }

  final _$getKeyYouTubeMovieAsyncAction =
      AsyncAction('_MovieStore.getKeyYouTubeMovie');

  @override
  Future<dynamic> getKeyYouTubeMovie(int movieId) {
    return _$getKeyYouTubeMovieAsyncAction
        .run(() => super.getKeyYouTubeMovie(movieId));
  }

  @override
  String toString() {
    return '''
topRateMoviesFuture: ${topRateMoviesFuture},
filterMoviesFuture: ${filterMoviesFuture},
moviePlayingFuture: ${moviePlayingFuture},
movieUpComingFuture: ${movieUpComingFuture},
movieList: ${movieList},
moviePlayingList: ${moviePlayingList},
movieUpComingList: ${movieUpComingList},
success: ${success},
loadingTopRateMovies: ${loadingTopRateMovies},
loadingMoviePlaying: ${loadingMoviePlaying},
loadingMovieUpComing: ${loadingMovieUpComing},
filtered: ${filtered}
    ''';
  }
}
