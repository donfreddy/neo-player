import 'package:animations/animations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/pages/albums/album_detail_page.dart';
import 'package:neo_player/src/pages/albums/widgets/album_card.dart';
import 'package:neo_player/src/provider/song_provider.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({Key? key}) : super(key: key);

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(context, title: 'Albums'),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          if (songProvider.artists.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 0),
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  padding: const EdgeInsets.all(2.0),
                  childAspectRatio: kChildAspectRatio,
                  children: songProvider.albums.map((album) {
                    return OpenContainer<bool>(
                      closedElevation: 0.0,
                      closedShape: const RoundedRectangleBorder(),
                      openColor: NeumorphicTheme.baseColor(context),
                      closedColor: NeumorphicTheme.baseColor(context),
                      openBuilder: (_, __) {
                        return AlbumDetailPage(album: album, mode: 1);
                      },
                      closedBuilder: (_, openContainer) {
                        return AlbumCard(album: album, onTap: openContainer);
                      },
                    );
                  }).toList(),
                ),
              ),
              const CoverLine(),
            ],
          );
        },
      ),
    );
  }
}
