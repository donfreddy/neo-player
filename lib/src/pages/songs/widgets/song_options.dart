import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:neo_player/src/common_widgets/top_bottom_sheet_bar.dart';
import 'package:neo_player/src/constants/constants.dart';
import 'package:neo_player/src/helpers/extensions.dart';
import 'package:neo_player/src/theme/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common_widgets/audio_artwork.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../common_widgets/modal_bottom_item.dart';
import '../../../helpers/common.dart';

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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: kAppContentPadding),
              child: AudioArtwork(audioId: song.id),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      song.title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      song.artist!.getArtist(),
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: theme.primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 60,
                child: IconBtn(
                  icon: Icons.favorite_rounded,
                  label: 'like'.tr(),
                  onPressed: () {
                    //
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: textGrayColor.withOpacity(0.2),
          height: 0.4,
        ),
        Column(
          children: [
            ModalBottomItem(
              icon: Icons.first_page_rounded,
              title: 'play_next'.tr(),
              iconColor: theme.primaryColor,
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.last_page_rounded,
              title: 'play_last'.tr(),
              iconColor: theme.primaryColor,
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.playlist_add_rounded,
              title: 'add_playlist'.tr(),
              iconColor: theme.primaryColor,
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.info_outline_rounded,
              title: 'Information',
              iconColor: theme.primaryColor,
              onTap: () => _buildSongInfoModal(context),
            ),
            ModalBottomItem(
              icon: Icons.share_rounded,
              title: 'share'.tr(),
              iconColor: theme.primaryColor,
              onTap: () {
                Share.shareFiles([song.data]);
              },
            ),
            ModalBottomItem(
              icon: Icons.phone_rounded,
              title: 'set_ringtone'.tr(),
              iconColor: theme.primaryColor,
              onTap: () {
                unImplementSnackBar(context);
              },
            ),
            ModalBottomItem(
              icon: Icons.delete_rounded,
              title: 'delete_from_device'.tr(),
              iconColor: theme.primaryColor,
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
          child: Text('Information', style: dialogTitleStyle(context)),
        ),
        titlePadding: const EdgeInsets.all(kAppContentPadding),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: kAppContentPadding),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SongInfoItem(name: 'title'.tr(), value: song.title),
            SongInfoItem(name: 'Album', value: song.album),
            SongInfoItem(name: 'artist'.tr(), value: song.artist!.getArtist()),
            SongInfoItem(name: 'location'.tr(), value: song.data),
            SongInfoItem(
                name: 'duration'.tr(),
                value: song.duration?.formatMSToHHMMSS()),
            SongInfoItem(name: 'size'.tr(), value: fileSize),
            SongInfoItem(
                name: 'file_extension'.tr(), value: song.fileExtension),
            SongInfoItem(
                name: 'date_modified'.tr(),
                value: song.dateModified?.toDateAndTime(context.locale)),
            SongInfoItem(name: 'year'.tr(), value: song.getMap['year']),
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
                    'ok'.tr(),
                    style: theme.textTheme.button!.copyWith(
                      color: theme.primaryColor,
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
          style: dialogContentStyle(context),
          children: [
            TextSpan(
              text: value ?? 'unknown'.tr(),
              style: dialogContentStyle(context)!.copyWith(
                color: textGrayColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
