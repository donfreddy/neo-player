import 'package:animations/animations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/ui/components/neo_app_bar.dart';
import 'package:neo_player/src/ui/pages/artists/widgets/artist_card.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../locator.dart';
import '../../../service/audio_query.dart';
import '../../components/cover_line.dart';
import 'artist_detail_page.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(context, title: 'Artists'),
      body: FutureBuilder<List<ArtistModel>>(
        future: locator<AudioQuery>().getArtists(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<ArtistModel> artists = snapshot.data!;
          return Stack(
            children: [
              GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                padding: const EdgeInsets.all(2.0),
                childAspectRatio: kChildAspectRatio,
                children: artists.map((artist) {
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
              const CoverLine(),
            ],
          );
        },
      ),
    );
  }
}
