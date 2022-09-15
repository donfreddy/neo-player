import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../neo_manager.dart';

final neoManager = locator<NeoManager>();

class PlayPaudseButton extends StatelessWidget {
  final AnimationController animationController;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const PlayPaudseButton({
    Key? key,
    required this.animationController,
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  void onPlayBtnPressed(ButtonState value) {
    if (value == ButtonState.playing) {
      neoManager.pause();
      animationController.forward();
    } else {
      neoManager.play();
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final neoManager = locator<NeoManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: neoManager.playButtonNotifier,
      builder: (_, value, __) {
        final isPlaying = value == ButtonState.playing;
        return NeumorphicButton(
          padding: padding,
          margin: margin,
          onPressed: () => onPlayBtnPressed(value),
          tooltip: isPlaying ? 'Pause' : 'play'.tr(),
          drawSurfaceAboveChild: false,
          style: NeumorphicStyle(
            color: Theme.of(context).primaryColor,
            depth: 2,
            shape: NeumorphicShape.flat,
            boxShape: const NeumorphicBoxShape.circle(),
          ),
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: Tween(begin: 0.0, end: 1.0).animate(animationController),
            color: Colors.white,
          ),
        );
      },
    );
  }
}
