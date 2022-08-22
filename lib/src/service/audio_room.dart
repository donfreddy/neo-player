import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class AudioRoom {
  final OnAudioRoom onAudioRoom;
  final avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');

  AudioRoom({required this.onAudioRoom});

  // ===========================================================================
  // ============================== PLAYLISTS ==================================
  // ===========================================================================

  // Will return the playlistId.
  // If the return is equal to 0, this playlist already exist.
  Future<int?> createPlaylist({required String name}) async {
    name.replaceAll(avoid, '').replaceAll('  ', ' ');
    return onAudioRoom.createPlaylist(name);
  }

  renamePlaylist({required int playlistId, required String newName}) async {
    newName.replaceAll(avoid, '').replaceAll('  ', ' ');
    return onAudioRoom.renamePlaylist(playlistId, newName);
  }

  updatePlaylist({required int playlistId, required SongEntity song}) async {
    return onAudioRoom.addTo(RoomType.PLAYLIST, song, ignoreDuplicate: false);
  }

  // Used to delete all the playlists
  Future<bool> clearPlaylists() async => onAudioRoom.clearPlaylists();

  Future<bool> deletePlaylist({required int playlistId}) async {
    return onAudioRoom.deletePlaylist(playlistId);
  }

  Future<List<PlaylistEntity>> getPlaylists() async {
    return onAudioRoom.queryPlaylists();
  }

  // check if a song was added to playlist
  Future<bool> checkInPlaylist({
    required int playlistId,
    required int songId,
  }) async {
    return onAudioRoom.checkIn(
      RoomType.PLAYLIST,
      songId,
      playlistKey: playlistId,
    );
  }

  // If the song was added, will return the songId.
  Future<int?> addToPlaylist({
    required int playlistId,
    required SongModel song,
  }) async {
    return onAudioRoom.addTo(
      RoomType.PLAYLIST,
      song.getMap.toSongEntity(),
      playlistKey: playlistId,
      ignoreDuplicate: false,
    );
  }

  Future<bool> removeFromPlaylist({
    required int playlistId,
    required int songId,
  }) async {
    return onAudioRoom.deleteFrom(
      RoomType.PLAYLIST,
      songId,
      playlistKey: playlistId,
    );
  }

  Future<List<SongEntity>> getPlaylistSongs(
    int playlistId, {
    RoomSortType? sortType,
    String? path,
  }) async {
    return onAudioRoom.queryAllFromPlaylist(playlistId, sortType: sortType);
  }

  // ===========================================================================
  // ============================== FAVORITES ==================================
  // ===========================================================================

  // check if a song was added to favorite
  Future<bool> checkInFavorites({required int songId}) async {
    return onAudioRoom.checkIn(RoomType.FAVORITES, songId);
  }

  // If the song was added, will return the songId.
  Future<int?> addToFavorites({required SongModel song}) async {
    return onAudioRoom.addTo(
      RoomType.FAVORITES,
      song.getMap.toFavoritesEntity(),
      ignoreDuplicate: false,
    );
  }

  Future<bool> deleteFromFavorites(int songId) async {
    return onAudioRoom.deleteFrom(RoomType.FAVORITES, songId);
  }

  Future<List<FavoritesEntity>> getFavoriteSongs(
      {RoomSortType? sortType}) async {
    return onAudioRoom.queryFavorites(sortType: sortType);
  }

  // ===========================================================================
  // ============================ LAST PLAYED ==================================
  // ===========================================================================

  Future<int?> addToLastPlayed({
    required int playlistId,
    required SongModel song,
  }) async {
    return onAudioRoom.addTo(
      RoomType.LAST_PLAYED,
      song.getMap.toSongEntity(),
      ignoreDuplicate: false,
    );
  }

  Future<List<LastPlayedEntity>> getLastPlayedSongs(
      {RoomSortType? sortType}) async {
    return onAudioRoom.queryLastPlayed(sortType: sortType);
  }
}
