import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neo_player/locator.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../local/repository/song_repository.dart';

class SongProvider extends ChangeNotifier {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final SongRepository _songRepository = locator<SongRepository>();

  late List<SongModel> songs;
  late List<AlbumModel> albums;
  late List<ArtistModel> artists;
  late List<GenreModel> genres;
  late SongModel _currentSong;
  int mode = 2;

  // Methods:--------------------------------------------------------------------

  /// Get the current song
  SongModel get song => _currentSong;

  Future<void> getSongs() async {
    songs = await _audioQuery.querySongs();
  }

  int get songCount => songs.length;

  bool get hasSong => songs.isNotEmpty;

  Future<void> getAlbums() async {
    albums = await _audioQuery.queryAlbums();
  }

  Future<void> getArtists() async {
    artists = await _audioQuery.queryArtists();
  }

  Future<void> getGenres() async {
    genres = await _audioQuery.queryGenres();
  }

  void setSong(SongModel song) async {
    _currentSong = song;
    notifyListeners();
  }

  void setMode(int mode) {
    this.mode = mode;
    notifyListeners();
  }
}

class TrackModel extends ChangeNotifier {}

// https://medium.com/flutter-community/making-sense-all-of-those-flutter-providers-e842e18f45dd
