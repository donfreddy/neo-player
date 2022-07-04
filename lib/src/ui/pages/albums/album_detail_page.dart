import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/ui/components/cover_line.dart';
import 'package:neo_player/src/ui/pages/albums/widgets/album_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../constants/constants.dart';
import '../../components/icon_btn.dart';
import '../../components/song_item.dart';
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
  List<SongModel> songs = [];

  @override
  void initState() {
    super.initState();
    initSongs();
  }

  //
  void initSongs() async {
    songs = await _audioQuery.queryAudiosFrom(
      AudiosFromType.ALBUM,
      {"album": widget.album.album},
    );

    // songs = await _audioQuery.querySongs();

    print("######################### Songs");
    print("######################### ${widget.album.id}");
    print(songs);
  }

  @override
  Widget build(BuildContext context) {
    String song = widget.album.numOfSongs == 1
        ? "${widget.album.numOfSongs} morceau"
        : "${widget.album.numOfSongs} morceaux";

    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: IconBtn(
            icon: Icons.arrow_back_rounded,
            label: 'Back',
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconBtn(
              icon: Icons.more_horiz_rounded,
              label: 'Option',
              onPressed: () {
                // Navigator.pop(context);
              }),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth(context) / 1.5,
                    height: 220.0,
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
                          child: AlbumArtwork(album: widget.album),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kAppContentPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.album.album,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.album.artist == '<unknown>'
                              ? 'Artiste inconnu'
                              : widget.album.artist!,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: NeumorphicTheme.accentColor(context),
                                  ),
                          maxLines: 1,
                        ),
                        Text(
                          "$song, 5 minutes",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: NeumorphicTheme.defaultTextColor(context)
                                    .withOpacity(0.8),
                              ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kAppContentPadding,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: IconTextBtn(
                            icon: Icons.play_arrow_rounded,
                            text: "Lire",
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
                    padding: const EdgeInsets.only(bottom: kMiniPlayerHeight),
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: songs.length,
                      itemBuilder: (BuildContext _, int index) {
                        return SongItem(
                          songId: songs[index].id,
                          title: songs[index].title,
                          artist: songs[index].artist,
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
  }
}

class IconTextBtn extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;

  const IconTextBtn({
    Key? key,
    required this.icon,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(
            Radius.circular(08.0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: NeumorphicTheme.accentColor(context),
          ),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: NeumorphicTheme.accentColor(context),
                ),
          ),
        ],
      ),
    );
  }
}
