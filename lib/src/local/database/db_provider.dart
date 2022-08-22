import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'migration/db_script.dart';

class DbProvider {
  DbProvider._();

  static final DbProvider dbProvider = DbProvider._();

  static Database? _database;
  final int _maxMigratedDbVersion = DbMigrator.migrations.keys.reduce(max);
  final String _dbName = 'NeoPlayer.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    _database = await openDatabase(
      path,
      version: _maxMigratedDbVersion,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
    );

    return _database!;
  }

  void onCreate(Database db, int _) async {
    // Create tables
    DbMigrator.migrations.keys.toList()
      ..sort()
      ..forEach((el) async {
        var script = DbMigrator.migrations[el]!;
        await db.transaction((txn) async => await txn.execute(script));
      });
  }

  void onUpgrade(Database db, int _, int __) async {
    var currentDbVersion = await getCurrentDbVersion(db);

    var upgradeScript = {
      for (var el
          in DbMigrator.migrations.keys.where((el) => el > currentDbVersion))
        el: DbMigrator.migrations[el]
    };

    if (upgradeScript.isEmpty) return;
    upgradeScript.keys.toList()
      ..sort()
      ..forEach((el) async {
        var script = upgradeScript[el]!;
        await db.transaction((txn) async => await txn.execute(script));
      });

    upgradeDbVersion(db, _maxMigratedDbVersion);
  }

  Future<int> getCurrentDbVersion(Database db) async {
    var res = await db.rawQuery('PRAGMA user_version;', null);
    var version = res[0]['user_version'].toString();
    return int.parse(version);
  }

  Future<void> upgradeDbVersion(Database db, int version) async {
    await db.rawQuery('pragma user_version = $version;');
  }

  Future<void> dropDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await deleteDatabase(path);
  }
}
