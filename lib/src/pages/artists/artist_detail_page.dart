import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../../helpers/common.dart';
import '../../service/audio_query.dart';
import '../albums/album_detail_page.dart';
import '../albums/widgets/album_card.dart';

class ArtistDetailPage extends StatefulWidget {
  final ArtistModel artist;

  const ArtistDetailPage({
    Key? key,
    required this.artist,
  }) : super(key: key);

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  List<AlbumModel> albums = [];
  List<SongModel> songs = [];
  String durations = '';
  List<String> countries = [
    "Brazil",
    "Nepal",
    "India",
    "China",
    "USA",
    "Canada"
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.position.pixels;
      });
      print(_scrollPosition);
    });
    initSongs();
  }

  void initSongs() async {
    albums = await locator<AudioQuery>().getAlbumsFromArtist(widget.artist.id);
    songs = await locator<AudioQuery>()
        .getSongsFromArtist(widget.artist.id, sortType: SongSortType.ALBUM);

    if (songs.length == 1) {
      durations = songs[0].duration!.toDuration();
    } else {
      durations = getTotalSongDuration(songs).toDuration();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: _scrollPosition > 33
              ? AnimatedOpacity(
                  opacity: _scrollPosition == 0 ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  child: Text(widget.artist.artist.getArtist(),
                      style: Theme.of(context).textTheme.titleMedium),
                )
              : null,
          actions: [
            IconBtn(
              icon: Icons.more_horiz_rounded,
              label: 'Option',
              onPressed: () {
                unImplementSnackBar(context);
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
              // const SliverToBoxAdapter(child: SizedBox(height: 10.0)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kAppContentPadding, vertical: 10.0),
                  child: Text(
                    widget.artist.artist.getArtist(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kAppContentPadding,
                      vertical: kAppContentPadding / 2),
                  child: Row(
                    children: [
                      Expanded(
                        child: IconTextBtn(
                          icon: Icons.play_arrow_rounded,
                          text: 'play_all'.tr(),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      Expanded(
                        child: IconTextBtn(
                          icon: Icons.shuffle,
                          text: 'shuffle'.tr(),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10.0)),
              SliverToBoxAdapter(
                child: albums.isNotEmpty
                    ? GridView.count(
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(2.0),
                        childAspectRatio: kChildAspectRatio,
                        children: albums.map((album) {
                          return OpenContainer<bool>(
                            closedElevation: 0.0,
                            closedShape: const RoundedRectangleBorder(),
                            openColor: NeumorphicTheme.baseColor(context),
                            closedColor: NeumorphicTheme.baseColor(context),
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            openBuilder: (_, __) {
                              return AlbumDetailPage(album: album, mode: 1);
                            },
                            closedBuilder: (_, openContainer) {
                              return AlbumCard(
                                  album: album, onTap: openContainer);
                            },
                          );
                        }).toList(),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: songs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SongCard(song: songs[index]);
                        },
                      ),
              ),
            ],
          ),
          const CoverLine()
        ],
      ),
    );
  }
}
