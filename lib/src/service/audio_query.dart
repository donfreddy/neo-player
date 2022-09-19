import 'package:on_audio_query/on_audio_query.dart';

class AudioQuery {
  final OnAudioQuery onAudioQuery;

  const AudioQuery({required this.onAudioQuery});

  Future<void> requestPermission() async {
    while (!await onAudioQuery.permissionsStatus()) {
      await onAudioQuery.permissionsRequest();
    }
  }

  Future<List<SongModel>> getSongs({
    SongSortType? sortType,
    OrderType? orderType,
    String? path,
  }) async {
    return onAudioQuery.querySongs(
      sortType: sortType,
      orderType: orderType,
      uriType: UriType.EXTERNAL,
      path: path,
    );
  }

  Future<List<ArtistModel>> getArtists({
    ArtistSortType? sortType,
    OrderType? orderType,
  }) async {
    return onAudioQuery.queryArtists(
      sortType: sortType,
      orderType: orderType,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<List<AlbumModel>> getAlbums({
    AlbumSortType? sortType,
    OrderType? orderType,
  }) async {
    return onAudioQuery.queryAlbums(
      sortType: sortType,
      orderType: orderType,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<List<AlbumModel>> getAlbumsFromArtist(
    int artistId, {
    AlbumSortType? sortType,
    OrderType? orderType,
  }) async {
    return getAlbums(
      sortType: sortType,
      orderType: orderType,
    ).then(
      (albums) => albums.where((album) => album.artistId == artistId).toList(),
    );
  }

  Future<List<GenreModel>> getGenres({
    GenreSortType? sortType,
    OrderType? orderType,
  }) async {
    return onAudioQuery.queryGenres(
      sortType: sortType,
      orderType: orderType,
      uriType: UriType.EXTERNAL,
    );
  }

  Future<List<SongModel>> getSongsFromArtist(
    int artistId, {
    SongSortType? sortType,
    OrderType? orderType,
    String? path,
  }) {
    return onAudioQuery.queryAudiosFrom(
      AudiosFromType.ARTIST_ID,
      artistId,
      sortType: sortType,
      orderType: orderType,
    );
  }

  Future<List<SongModel>> getSongsFromAlbum(
    int albumId, {
    SongSortType? sortType,
    OrderType? orderType,
    String? path,
  }) {
    return onAudioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      albumId,
      sortType: sortType,
      orderType: orderType,
    );
  }
}
