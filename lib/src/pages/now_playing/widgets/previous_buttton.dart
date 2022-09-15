import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../../../common_widgets/common_widgets.dart';
import '../neo_manager.dart';

class PreviousButton extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;

  const PreviousButton({
    Key? key,
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: locator<NeoManager>().isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconBtn(
          icon: Icons.fast_rewind_rounded,
          label: 'previous'.tr(),
          iconSize: 24.0,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(14.0),
          onPressed: (isFirst) ? null : locator<NeoManager>().skipToPrevious,
        );
      },
    );
  }
}
