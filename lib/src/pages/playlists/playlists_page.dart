import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../../common_widgets/common_widgets.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(
        context,
        title: 'playlists'.tr(),
        onTapSorting: () {},
      ),
      body: const SingleChildScrollView(),
    );
  }
}
