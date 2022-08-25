import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/ui/components/custom_material.dart';
import 'package:neo_player/src/ui/components/unselected_sort.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../provider/song_provider.dart';
import '../../components/cover_line.dart';
import '../../components/icon_text_btn.dart';
import '../../components/neo_app_bar.dart';
import '../../components/selected_sort.dart';
import '../../components/song_item.dart';
import '../../theme/style.dart';
import '../../theme/theme.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(
        context,
        title: 'Morceaux',
        onTapSorting: _buildSortingModal,
      ),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          if (songProvider.songs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scrollbar(
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 12.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kAppContentPadding),
                          child: Row(
                            children: [
                              Expanded(
                                child: IconTextBtn(
                                  icon: Icons.play_arrow_rounded,
                                  text: 'Tout lire',
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 30.0),
                              Expanded(
                                child: IconTextBtn(
                                  icon: Icons.shuffle,
                                  text: 'Aleatoire',
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          padding:
                              const EdgeInsets.only(bottom: kMiniPlayerHeight),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: songProvider.songs.length,
                            itemBuilder: (context, int index) {
                              SongModel song = songProvider.songs[index];
                              return SongItem(
                                songId: song.id,
                                title: song.title,
                                artist: song.artist,
                                onPressed: () {
                                  // print(
                                  //     "########################################: ${song.uri}");
                                  // print("================================>");
                                  // print(
                                  //     "########################################: $song");
                                  // final mediaItem =
                                  //     MediaItemConverter.mapToMediaItem(
                                  //         song.getMap);
                                  // final neoManager = locator<NeoManager>();
                                  //
                                  // print(mediaItem);
                                  //
                                  // neoManager.addToNowPlaying(
                                  //     context: context, mediaItem: mediaItem);
                                  //
                                  // neoManager.play();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const NowPlaying(),
                                  //   ),
                                  // );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const CoverLine()
              ],
            ),
          );
        },
      ),
    );
  }

  Future _buildSortingModal() {
    return showModal(
      context: context,
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: kShortDuration,
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius),
          ),
          backgroundColor: NeumorphicTheme.baseColor(context),
          title: Center(
            child: Text(
              'Sorting',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          titlePadding: const EdgeInsets.all(kAppContentPadding),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: kAppContentPadding) +
                  const EdgeInsets.only(bottom: kAppContentPadding - 2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UnSelectSort(title: 'Title', icon: Icons.title),
              const SizedBox(height: 6),
              const UnSelectSort(title: 'Artist', icon: Icons.person_rounded),
              const SizedBox(height: 6),
              const UnSelectSort(title: 'Album', icon: Icons.album_rounded),
              const SizedBox(height: 6),
              const UnSelectSort(
                  title: 'Duration', icon: Icons.schedule_rounded),
              const SizedBox(height: 6),
              const UnSelectSort(title: 'Date Added', icon: Icons.playlist_add),
              const SizedBox(height: 6),
              const SelectedSort(
                  title: 'Display Name', icon: Icons.text_fields),
              const SizedBox(height: 6),
              const UnSelectSort(title: 'Size', icon: Icons.memory_rounded),
              const SizedBox(height: 6),
              Container(
                width: screenWidth(context),
                color: textGrayColor.withOpacity(0.4),
                height: 0.4,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Neumorphic(
                      margin: const EdgeInsets.all(5.0),
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                          const BorderRadius.all(Radius.circular(kRadius)),
                        ),
                        disableDepth: true,
                      ),
                      child: MaterialWitchInkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.expand_less_rounded,
                                color: Colors.red,
                              ),
                              Text(
                                'Ascending',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.expand_more_rounded,
                          color: Colors.red,
                        ),
                        Text(
                          'Descending',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
