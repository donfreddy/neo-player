import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/common_widgets/top_bottom_sheet_bar.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:neo_player/src/theme/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common_widgets/modal_bottom_item.dart';
import '../../../helpers/helpers.dart';

class SongOptions extends StatelessWidget {
  final SongModel song;

  const SongOptions({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBottomSheetBar(),
        Container(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: kAppContentPadding),
          child: Text(
            song.displayNameWOExt,
            style: theme.textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: textGrayColor.withOpacity(0.2),
          height: 0.4,
        ),
        Column(
          children: [
            ModalBottomItem(
              icon: Icons.skip_next_rounded,
              title: 'Play next',
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.add_to_queue_rounded,
              title: 'Add to Playing Queue',
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.favorite_rounded,
              title: 'Add to favorite',
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.playlist_add_rounded,
              title: 'Add to playlist',
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.info_rounded,
              title: 'Information',
              onTap: () => _buildSongInfoModal(context),
            ),
            ModalBottomItem(
              icon: Icons.share_rounded,
              title: 'Share',
              onTap: () {
                Share.shareFiles([song.data]);
              },
            ),
            ModalBottomItem(
              icon: Icons.phone_rounded,
              title: 'Set as Ringtone',
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.delete_rounded,
              title: 'Delete from Device',
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
          ],
        )
      ],
    );
  }

  Future<dynamic> _buildSongInfoModal(BuildContext context) async {
    final theme = Theme.of(context);
    final fileSize = await getFileSize(song.data);
    return showModal(
      context: context,
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(
          milliseconds: 300,
        ),
      ),
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadius),
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
        title: Center(
          child: Text(
            'Information',
            style: dialogTitleStyle(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        titlePadding: const EdgeInsets.all(kAppContentPadding),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: kAppContentPadding),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SongInfoItem(name: 'Title', value: song.title),
            SongInfoItem(name: 'Album', value: song.album),
            SongInfoItem(name: 'Artist', value: song.artist!.getArtist()),
            SongInfoItem(name: 'Location', value: song.data),
            SongInfoItem(
                name: 'Duration', value: song.duration?.formatMSToHHMMSS()),
            SongInfoItem(name: 'File size', value: fileSize),
            SongInfoItem(name: 'File extension', value: song.fileExtension),
            SongInfoItem(
                name: 'Date modified',
                value: song.dateModified?.toDateAndTime(context.locale)),
            SongInfoItem(name: 'Year', value: song.getMap['year']),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      theme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Okay',
                    style: theme.textTheme.button!.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SongInfoItem extends StatelessWidget {
  final String name;
  final String? value;

  const SongInfoItem({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$name: ',
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: value ?? 'Unknown',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: textGrayColor,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
