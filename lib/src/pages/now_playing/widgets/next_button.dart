import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../../../common_widgets/common_widgets.dart';
import '../neo_manager.dart';

class NextButton extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;

  const NextButton({
    Key? key,
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: locator<NeoManager>().isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconBtn(
          icon: Icons.fast_forward_rounded,
          label: 'next'.tr(),
          padding: padding,
          margin: margin,
          iconSize: 24,
          onPressed: (isLast) ? null : locator<NeoManager>().skipToNext,
        );
      },
    );
  }
}
