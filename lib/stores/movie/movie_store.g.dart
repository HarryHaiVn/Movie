// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MovieStore on _MovieStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_MovieStore.loading'))
      .value;
  Computed<bool>? _$filteredComputed;

  @override
  bool get filtered => (_$filteredComputed ??=
          Computed<bool>(() => super.filtered, name: '_MovieStore.filtered'))
      .value;

  final _$fetchMoviesFutureAtom = Atom(name: '_MovieStore.fetchMoviesFuture');

  @override
  ObservableFuture<TopRateResponse?> get fetchMoviesFuture {
    _$fetchMoviesFutureAtom.reportRead();
    return super.fetchMoviesFuture;
  }

  @override
  set fetchMoviesFuture(ObservableFuture<TopRateResponse?> value) {
    _$fetchMoviesFutureAtom.reportWrite(value, super.fetchMoviesFuture, () {
      super.fetchMoviesFuture = value;
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
fetchMoviesFuture: ${fetchMoviesFuture},
filterMoviesFuture: ${filterMoviesFuture},
movieList: ${movieList},
success: ${success},
loading: ${loading},
filtered: ${filtered}
    ''';
  }
}
