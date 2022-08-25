import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/ui/components/custom_material.dart';
import 'package:neo_player/src/ui/components/sort_type_item.dart';
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
  late bool isSelected = false;
  final ScrollController _scrollController = ScrollController();

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
          return RawScrollbar(
            thumbColor: Theme.of(context).primaryColor,
            radius: const Radius.circular(kRadius * 2),
            thickness: 4,
            minThumbLength: 40,
            controller: _scrollController,
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
          title: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Sorting',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: GestureDetector(
                  child: const Icon(Icons.cancel, size: 20.0),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0) +
              const EdgeInsets.only(bottom: 10.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SortTypeItem(
                title: 'Title',
                icon: Icons.title,
                isSelected: false,
                onSortSelect: () {},
              ),
              SortTypeItem(
                title: 'Artist',
                icon: Icons.mic,
                isSelected: false,
                onSortSelect: () {},
              ),
              SortTypeItem(
                title: 'Album',
                icon: Icons.album_rounded,
                isSelected: false,
                onSortSelect: () {},
              ),
              SortTypeItem(
                title: 'Duration',
                icon: Icons.schedule_rounded,
                isSelected: true,
                onSortSelect: () {},
              ),
              SortTypeItem(
                title: 'Date Added',
                icon: Icons.playlist_add,
                isSelected: false,
                onSortSelect: () {},
              ),
              SortTypeItem(
                title: 'Display Name',
                icon: Icons.text_fields_rounded,
                isSelected: false,
                onSortSelect: () {},
              ),
              SortTypeItem(
                title: 'Size',
                icon: Icons.memory_rounded,
                isSelected: false,
                onSortSelect: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 10.0),
                child: Container(
                  width: screenWidth(context),
                  color: textGrayColor.withOpacity(0.4),
                  height: 0.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OrderTypeItem(
                      title: 'Ascending',
                      icon: Icons.expand_less_rounded,
                      isSelected: isSelected,
                      onOrderSelect: () {
                        setState(() {
                          isSelected = true;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: OrderTypeItem(
                      title: 'Descending',
                      icon: Icons.expand_more_rounded,
                      isSelected: !isSelected,
                      onOrderSelect: () {
                        setState(() {
                          isSelected = false;
                        });
                      },
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

class OrderTypeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function()? onOrderSelect;

  const OrderTypeItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
    this.onOrderSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Neumorphic(
      margin: const EdgeInsets.all(5.0),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(kRadius)),
        ),
        disableDepth: !isSelected,
      ),
      child: MaterialWitchInkWell(
        onTap: onOrderSelect,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? theme.primaryColor : null,
              ),
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: isSelected ? theme.primaryColor : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
