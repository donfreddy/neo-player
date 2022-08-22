import '../../model/song.dart';

final String createSongsTable = '''
      CREATE TABLE ${Song.tableName} (
          ${Song.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Song.columnTitle} TEXT,
          ${Song.columnArtist} TEXT,
          ${Song.columnAlbum} TEXT,
          ${Song.columnAlbumId} INTEGER,
          ${Song.columnAlbumArt} TEXT,
          ${Song.columnDuration} INTEGER,
          ${Song.columnUri} TEXT,
          ${Song.columnIsFav} INTEGER NOT NULL default 0,
          ${Song.columnTimeStamp} INTEGER NOT NULL default 0,
          ${Song.columnCount} INTEGER NOT NULL default 0,
          );
    ''';

final String createRecentSongsTable = '''
      CREATE TABLE recent (
          ${Song.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Song.columnTitle} TEXT,
          ${Song.columnArtist} TEXT,
          ${Song.columnAlbum} TEXT,
          ${Song.columnAlbumId} INTEGER,
          ${Song.columnAlbumArt} TEXT,
          ${Song.columnDuration} INTEGER,
          ${Song.columnUri} TEXT,
    ''';
