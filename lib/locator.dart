import 'package:get_it/get_it.dart';
// import 'package:neo_player/src/local/dao/song_dao.dart';
import 'package:neo_player/src/local/repository/song_repository.dart';
import 'package:neo_player/src/provider/settings_provider.dart';
import 'package:neo_player/src/provider/song_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // locator.registerLazySingleton(() => SongDao());
  locator.registerLazySingleton(() => SongProvider());
  locator.registerLazySingleton(() => SongRepository());
  locator.registerSingleton(() => SettingsProvider(locator()));

  // External library:----------------------------------------------------------
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
