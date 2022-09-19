import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/pages/artists/widgets/artist_card.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../locator.dart';
import '../../common_widgets/common_widgets.dart';
import '../../models/sort_item.dart';
import '../../service/audio_query.dart';
import '../../theme/style.dart';
import '../../theme/theme.dart';
import 'artist_detail_page.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  int songSortValue =
      Hive.box('settings').get('artistSortValue', defaultValue: 0) as int;
  int songOrderValue =
      Hive.box('settings').get('artistOrderValue', defaultValue: 0) as int;

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(
        context,
        title: 'artists'.tr(),
        onTapSorting: _buildSortingModal,
      ),
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
                    openBuilder: (_, __) {
                      return ArtistDetailPage(artist: artist);
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
                    'sorting'.tr(),
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
                children: artistSortItems
                    .map(
                      (item) => SortTypeItem(
                        title: item.title,
                        icon: item.icon,
                        value: artistSortItems.indexOf(item),
                        isSelected:
                            songSortValue == artistSortItems.indexOf(item),
                        onSortSelect: (int value) async {
                          if (songSortValue == value) return;
                          await Hive.box('settings')
                              .put('songSortValue', value);
                          setState(() {
                            songSortValue = value;
                          });
                          // _songsNotifier.loadSongs(
                          //     songSortValue, songOrderValue);
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
                            // _songsNotifier.loadSongs(
                            //     songSortValue, songOrderValue);
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
