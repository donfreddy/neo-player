import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../../../common_widgets/common_widgets.dart';
import '../neo_manager.dart';

final neoManager = locator<NeoManager>();

class PlayPauseButton extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;

  const PlayPauseButton({
    Key? key,
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  void onPlayBtnPressed(ButtonState value) {
    if (value == ButtonState.playing) {
      neoManager.pause();
    } else {
      neoManager.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: neoManager.playButtonNotifier,
      builder: (_, value, __) {
        if (value == ButtonState.playing) {
          return IconBtn(
            icon: Icons.pause_rounded,
            label: 'Pause',
            padding: padding,
            margin: margin,
            color: Theme.of(context).primaryColor,
            iconSize: 24,
            onPressed: () => onPlayBtnPressed(value),
          );
        } else {
          return IconBtn(
            icon: Icons.play_arrow_rounded,
            label: 'play'.tr(),
            padding: padding,
            margin: margin,
            color: Theme.of(context).primaryColor,
            iconSize: 24,
            onPressed: () => onPlayBtnPressed(value),
          );
        }
      },
    );
  }
}
