import 'package:animations/animations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/provider/song_provider.dart';
import 'package:neo_player/src/ui/components/neo_app_bar.dart';
import 'package:neo_player/src/ui/pages/artists/widgets/artist_card.dart';
import 'package:provider/provider.dart';

import '../../components/cover_line.dart';
import 'artist_detail_page.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(context, "Artists"),
      body: Consumer<SongProvider>(
        builder: (context, songProvider, child) {
          if (songProvider.artists.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: kMiniPlayerHeight),
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(2.0),
                  childAspectRatio: kChildAspectRatio,
                  children: songProvider.artists.map((artist) {
                    return OpenContainer<bool>(
                      closedElevation: 0.0,
                      closedShape: const RoundedRectangleBorder(),
                      openColor: NeumorphicTheme.baseColor(context),
                      closedColor: NeumorphicTheme.baseColor(context),
                      transitionDuration: const Duration(milliseconds: 500),
                      openBuilder: (_, __) {
                        return ArtistDetailPage(artist: artist, mode: 1);
                      },
                      closedBuilder: (_, openContainer) {
                        return ArtistCard(artist: artist, onTap: openContainer);
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
