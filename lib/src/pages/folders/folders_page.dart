import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../common_widgets/common_widgets.dart';

class FoldersPage extends StatelessWidget {
  const FoldersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neoAppBar(
        context,
        title: 'folders'.tr(),
        onTapSorting: () {},
      ),
      body: const SingleChildScrollView(),
    );
  }
}
