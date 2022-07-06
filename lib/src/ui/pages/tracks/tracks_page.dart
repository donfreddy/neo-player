import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../../provider/song_provider.dart';
import '../../components/cover_line.dart';
import '../../components/icon_text_btn.dart';
import '../../components/neo_app_bar.dart';
import '../../components/song_item.dart';

class TracksPage extends StatefulWidget {
  const TracksPage({Key? key}) : super(key: key);

  @override
  State<TracksPage> createState() => _TracksPageState();
}

class _TracksPageState extends State<TracksPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(context, "Morceaux"),
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
                                  text: "Tout lire",
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 30.0),
                              Expanded(
                                child: IconTextBtn(
                                  icon: Icons.shuffle,
                                  text: "Aleatoire",
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
}
