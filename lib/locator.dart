/*
 *  This file is part of Neo Player (https://github.com/Donfreddy/neo-player).
 *
 * Neo Player is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Neo Player is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright (c) 2022-2023, Don Freddy
 */

import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:neo_player/src/local/repository/song_repository.dart';
import 'package:neo_player/src/provider/settings_provider.dart';
import 'package:neo_player/src/provider/song_provider.dart';
import 'package:neo_player/src/service/audio_handler.dart';
import 'package:neo_player/src/service/audio_query.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/pages/now_playing/neo_manager.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // locator.registerLazySingleton(() => SongDao());
  locator.registerLazySingleton(() => SongRepository());

  // providers
  locator.registerLazySingleton(() => SongProvider());
  locator.registerSingleton(() => SettingsProvider(locator()));

  // service
  locator.registerFactory(() => AudioQuery(onAudioQuery: locator()));
  locator.registerSingleton<AudioHandler>(await initAudioService());

  // neo state
  locator.registerLazySingleton<NeoManager>(() => NeoManager());

  // External library:----------------------------------------------------------
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => OnAudioQuery());
}
