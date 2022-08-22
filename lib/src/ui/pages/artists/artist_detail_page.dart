import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../constants/constants.dart';
import '../../../helpers/helpers.dart';
import '../../components/icon_btn.dart';
import '../../components/icon_text_btn.dart';

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppContentPadding,
                vertical: kAppContentPadding / 2),
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
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.5),
                    tabs: const [
                      Tab(
                        text: 'Albums',
                      ),
                      Tab(
                        text: 'Songs',
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: List.generate(
                            100,
                            (index) => Text('$index Album'),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: List.generate(
                              100,
                              (index) => Text('$index song'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// // Create album list
// class AlbumsList extends StatefulWidget {
//   final ArtistModel artist;
//   final int mode;
//
//   const AlbumsList({
//     Key? key,
//     required this.artist,
//     required this.mode,
//   }) : super(key: key);
//
//   @override
//   State<AlbumsList> createState() => _AlbumsListState();
// }
//
// class _AlbumsListState extends State<AlbumsList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: widget.artist.albums.length,
//       itemBuilder: (context, index) {
//         final album = widget.artist.albums[index];
//         return ListTile(
//           leading: album.cover != null
//               ? Image.file(
//                   album.cover,
//                   fit: BoxFit.cover,
//                 )
//               : const SizedBox.shrink(),
//           title: Text(album.title),
//           subtitle: Text(album.artist),
//           trailing: Text(album.year),
//           onTap: () {
//             // Navigator.pushNamed(
//             //   context,
//             //   '/album',
//             //   arguments: AlbumDetailArguments(
//             //     album: album,
//             //     mode: widget.mode,
//             //   ),
//             // );
//           },
//         );
//       },
//     );
//   }
// }
//
// // create songs list
// class SongsList extends StatefulWidget {
//   final ArtistModel artist;
//   final int mode;
//
//   const SongsList({
//     Key? key,
//     required this.artist,
//     required this.mode,
//   }) : super(key: key);
//
//   @override
//   State<SongsList> createState() => _SongsListState();
// }
//
// class _SongsListState extends State<SongsList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: widget.artist.songs.length,
//       itemBuilder: (context, index) {
//         final song = widget.artist.songs[index];
//         return ListTile(
//           leading: song.artwork != null
//               ? Image.memory(
//                   song.artwork,
//                   fit: BoxFit.cover,
//                   width: 50,
//                   height: 50,
//                 )
//               : null,
//           title: Text(song.title),
//           subtitle: Text(song.artist),
//           trailing: IconBtn(
//             icon: Icons.more_horiz_rounded,
//             label: 'Option',
//             onPressed: () {
//               unImplementSnackBar(context);
//             },
//           ),
//           onTap: () {
//             // Navigator.pushNamed(
//             //   context,
//             //   '/player',
//             //   arguments: PlayerArguments(
//             //     song: song,
//             //     mode: widget.mode,
//             //   ),
//             // );
//           },
//         );
//       },
//     );
//   }
// }
