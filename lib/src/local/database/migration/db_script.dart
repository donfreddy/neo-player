import 'db_init.dart';

class DbMigrator {
  static final Map<int, String> migrations = {
    1: createSongsTable,
    2: createRecentSongsTable,
  };
}
