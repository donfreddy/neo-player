import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/pages/songs/songs_notifier.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

import '../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../helpers/media_item_converter.dart';
import '../../theme/style.dart';
import '../../theme/theme.dart';
import '../now_playing/neo_manager.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  final _songsNotifier = SongsNotifier();
  final neoManager = locator<NeoManager>();
  final _scrollController = ScrollController();
  int songSortValue =
      Hive.box('settings').get('songSortValue', defaultValue: 0) as int;
  int songOrderValue =
      Hive.box('settings').get('songOrderValue', defaultValue: 0) as int;

  @override
  void initState() {
    _songsNotifier.loadSongs(songSortValue, songOrderValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: neoAppBar(
          context,
          title: 'Morceaux',
          onTapSorting: _buildSortingModal,
        ),
        body: RawScrollbar(
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
                                onPressed: () {
                                  //
                                },
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
                            const EdgeInsets.only(bottom: kPlayerMinHeight),
                        child: ValueListenableBuilder<List<SongModel>>(
                          valueListenable: _songsNotifier,
                          builder: (_, songs, __) {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: songs.length,
                              itemBuilder: (_, index) {
                                SongModel song = songs[index];
                                return SongItem(
                                  song: song,
                                  onPressed: () {
                                    getTemporaryDirectory()
                                        .then((tempDir) async {
                                      print(tempDir.path);
                                      final File file =
                                          File('${tempDir.path}/artist.png');
                                      if (!await file.exists()) {
                                        final byteData = await rootBundle
                                            .load('assets/images/artist.png');
                                        await file.writeAsBytes(
                                          byteData.buffer.asUint8List(
                                              byteData.offsetInBytes,
                                              byteData.lengthInBytes),
                                        );
                                      }
                                      final mediaItem =
                                          MediaItemConverter.mapToMediaItem(
                                              song.getMap, tempDir);

                                      neoManager.addQueueItem(mediaItem);
                                      if (kDebugMode) {
                                        print(song.getMap);
                                        print('============> MediaItem');
                                        print(mediaItem);
                                      }
                                    });

                                    neoManager.play();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const NowPlaying(),
                                    //   ),
                                    // );
                                  },
                                );
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
        ));
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
                    style: dialogTitleStyle(context),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: kAppContentPadding) +
                  const EdgeInsets.only(bottom: 10.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: songSortItems
                    .map(
                      (item) => SortTypeItem(
                        title: item.title,
                        icon: item.icon,
                        value: songSortItems.indexOf(item),
                        isSelected:
                            songSortValue == songSortItems.indexOf(item),
                        onSortSelect: (int value) async {
                          if (songSortValue == value) return;
                          await Hive.box('settings')
                              .put('songSortValue', value);
                          setState(() {
                            songSortValue = value;
                          });
                          _songsNotifier.loadSongs(
                              songSortValue, songOrderValue);
                        },
                      ),
                    )
                    .toList(),
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
                children: orderItems
                    .map(
                      (item) => Expanded(
                        child: OrderTypeItem(
                          title: item.title,
                          icon: item.icon,
                          value: orderItems.indexOf(item),
                          isSelected:
                              songOrderValue == orderItems.indexOf(item),
                          onOrderSelect: (int value) async {
                            if (songOrderValue == value) return;
                            await Hive.box('settings')
                                .put('songOrderValue', songOrderValue);
                            setState(() {
                              songOrderValue = value;
                            });
                            _songsNotifier.loadSongs(
                                songSortValue, songOrderValue);
                          },
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SortItem {
  final IconData icon;
  final String title;

  SortItem({required this.icon, required this.title});
}

final List<SortItem> songSortItems = [
  SortItem(icon: Icons.title, title: 'Title'),
  SortItem(icon: Icons.mic, title: 'Artist'),
  SortItem(icon: Icons.album_rounded, title: 'Album'),
  SortItem(icon: Icons.schedule_rounded, title: 'Duration'),
  SortItem(icon: Icons.title, title: 'Date Added'),
  SortItem(icon: Icons.dns_rounded, title: 'Size'),
  SortItem(icon: Icons.text_fields_rounded, title: 'Display Name'),
];

final List<SortItem> orderItems = [
  SortItem(icon: Icons.expand_less_rounded, title: 'Ascending'),
  SortItem(icon: Icons.expand_more_rounded, title: 'Descending'),
];
