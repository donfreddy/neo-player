import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../locator.dart';
import '../../../constants/constants.dart';
import '../../../helpers/helpers.dart';
import '../../../service/audio_query.dart';
import '../../components/cover_line.dart';
import '../../components/icon_btn.dart';
import '../../components/icon_text_btn.dart';
import '../albums/album_detail_page.dart';
import '../albums/widgets/album_card.dart';

class ArtistDetailPage extends StatefulWidget {
  final ArtistModel artist;
  final int mode;

  const ArtistDetailPage({
    Key? key,
    required this.artist,
    required this.mode,
  }) : super(key: key);

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  final ScrollController _scrollController = ScrollController();

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
          title: Text(
            widget.artist.artist.getArtist(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
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
                          text: 'Play All',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      Expanded(
                        child: IconTextBtn(
                          icon: Icons.shuffle,
                          text: 'Shuffle',
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Container(
                padding: const EdgeInsets.only(
                    top: 5.0, bottom: kBottomNavBarHeight),
                child: FutureBuilder<List<AlbumModel>>(
                    future: locator<AudioQuery>().getAlbums(),
                    builder: (context, snapshot) {
                      if (kDebugMode) {
                        print(snapshot.data);
                      }

                      if (!snapshot.hasData) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      List<AlbumModel> albums = snapshot.data!;

                      print(albums);

                      return GridView.count(
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
                      );
                    }),
              )),
              SliverToBoxAdapter(),
            ],
          ),
          const CoverLine()
        ],
      ),
    );
  }
}
