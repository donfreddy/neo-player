import '../database/db_provider.dart';

/// [SongDao] is dedicated to manage all local Database Create Read
/// Update Delete (CRUD) operations for Song model asynchronously.
/// This will be main communicator between the [SongRepository] &
/// our [DbProvider].
class SongDao {
  final dbProvider = DbProvider.dbProvider;

  // Insert user songs in to database
  Future<int> insertSongs() async {
    final db = await dbProvider.database;

    db.insert("", {});
    return 1;
  }
}
