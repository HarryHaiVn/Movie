import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/models/movie/top_rate_response.dart';
import 'package:sembast/sembast.dart';

class MovieDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _movieStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  MovieDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Movie movie) async {
    return await _movieStore.add(_db, movie.toMap());
  }

  Future updateOrInsert(Movie movie) async {
    await _movieStore.record(movie.id ?? -1).put(_db, movie.toMap());
  }

  Future<int> count() async {
    return await _movieStore.count(_db);
  }

  Future<List<Movie>?> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _movieStore.find(
      _db,
      finder: finder,
    );

    // Making a List<Movie> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final movie = Movie.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      movie.setId = snapshot.key;
      return movie;
    }).toList();
  }

  Future<List<Movie>?> getMovieFromDb() async {
    print('Loading from database');

    // movie list
    List<Movie>? moviesList = List.empty();

    // fetching data
    final recordSnapshots = await _movieStore.find(
      _db,
    );
    // Making a List<Movie> out of List<RecordSnapshot>
    if (recordSnapshots.length > 0) {
      moviesList = recordSnapshots.map((snapshot) {
        final movie = Movie.fromMap(snapshot.value);
        // An ID is a key of a record from the database.
        movie.setId = snapshot.key;
        return movie;
      }).toList();
      print(moviesList.length);
    }
    return moviesList;
  }

  Future<int> update(Movie movie) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(movie.id));
    return await _movieStore.update(
      _db,
      movie.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Movie movie) async {
    final finder = Finder(filter: Filter.byKey(movie.id));
    return await _movieStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _movieStore.drop(
      _db,
    );
  }
}
