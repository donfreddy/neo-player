import 'package:on_audio_query/on_audio_query.dart';

final Map<int, SongSortType> songSortTypes = {
  0: SongSortType.TITLE,
  1: SongSortType.ARTIST,
  2: SongSortType.ALBUM,
  3: SongSortType.DURATION,
  4: SongSortType.DATE_ADDED,
  5: SongSortType.DISPLAY_NAME,
  6: SongSortType.SIZE,
};

final Map<int, ArtistSortType> artistSortTypes = {
  0: ArtistSortType.ARTIST,
  1: ArtistSortType.NUM_OF_TRACKS,
  2: ArtistSortType.NUM_OF_ALBUMS,
};

final Map<int, AlbumSortType> albumSortTypes = {
  0: AlbumSortType.ALBUM,
  1: AlbumSortType.ARTIST,
  2: AlbumSortType.NUM_OF_SONGS,
};

final Map<int, OrderType> orderTypes = {
  0: OrderType.ASC_OR_SMALLER,
  1: OrderType.DESC_OR_GREATER,
};
