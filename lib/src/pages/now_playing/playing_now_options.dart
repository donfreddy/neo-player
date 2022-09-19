import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../common_widgets/modal_bottom_item.dart';
import '../../common_widgets/top_bottom_sheet_bar.dart';
import '../../helpers/common.dart';

class PlayingNowOptions extends StatelessWidget {
  const PlayingNowOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TopBottomSheetBar(),
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
          onTap: () => unImplementSnackBar(context),
        ),
        ModalBottomItem(
          icon: Icons.share_rounded,
          title: 'share'.tr(),
          iconColor: theme.primaryColor,
          onTap: () {
            // Share.shareFiles([]);
            unImplementSnackBar(context);
          },
        ),
      ],
    );
  }
}
