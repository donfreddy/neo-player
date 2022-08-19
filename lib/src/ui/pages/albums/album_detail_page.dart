import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/ui/components/cover_line.dart';
import 'package:neo_player/src/ui/components/query_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../constants/constants.dart';
import '../../../helpers/int_to_duration.dart';
import '../../components/icon_btn.dart';
import '../../components/icon_text_btn.dart';
import '../../components/song_item.dart';
import '../../theme/style.dart';
import '../../theme/theme.dart';

class AlbumDetailPage extends StatefulWidget {
  final AlbumModel album;
  final int mode;

  const AlbumDetailPage({
    Key? key,
    required this.album,
    required this.mode,
  }) : super(key: key);

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  List<SongModel> songs = [];
  String durations = "";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    initSongs();
  }

  void _scrollListener() {
    print("### Scroll Position ${_scrollController.position.pixels.floor()}");
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  void initSongs() async {
    songs = await _audioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM_ID,
      widget.album.id,
    );

    if (songs.length == 1) {
      durations = intToDuration(songs[0].duration ?? 0);
    } else {
      durations = intToDuration(getTotalInt(songs));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String song = widget.album.numOfSongs == 1
        ? "${widget.album.numOfSongs} morceau"
        : "${widget.album.numOfSongs} morceaux";

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kAppBarHeight),
        child: AppBar(
          backgroundColor: NeumorphicTheme.baseColor(context),
          elevation: 0,
          leading: Column(
            children: [
              IconBtn(
                icon: Icons.arrow_back_rounded,
                label: 'Back',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          centerTitle: true,
          title: _scrollPosition > 240
              ? AnimatedOpacity(
                  opacity: _scrollPosition == 0 ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  child: Text(widget.album.album,
                      style: Theme.of(context).textTheme.titleMedium),
                )
              : null,
          actions: [
            IconBtn(
              icon: Icons.more_horiz_rounded,
              label: 'Option',
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            const SizedBox(width: kAppContentPadding / 2),
          ],
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: Hero(
                        tag: 'album ${widget.album.id}',
                        child: Neumorphic(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6),
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(kRadius)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(kImagePadding),
                            child: QueryArtwork(
                              artworkId: widget.album.id,
                              artworkType: ArtworkType.ALBUM,
                              defaultPath: "assets/images/album.jpg",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kAppContentPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          widget.album.album,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Text(
                            widget.album.artist == '<unknown>'
                                ? 'Unknown Artist'
                                : widget.album.artist!,
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: NeumorphicTheme.accentColor(context),
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          "$song • $durations",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: textGrayColor),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kAppContentPadding,
                      vertical: kAppContentPadding,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: IconTextBtn(
                            icon: Icons.play_arrow_rounded,
                            text: "Play All",
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: IconTextBtn(
                            icon: Icons.shuffle,
                            text: "Shuffle",
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return SongItem(
                      songId: songs[index].id,
                      title: songs[index].title,
                      artist: songs[index].artist,
                    );
                  },
                  childCount: songs.length,
                )),
              ]),
          const CoverLine()
        ],
      ),
    );
  }
}
