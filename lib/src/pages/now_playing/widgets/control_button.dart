import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../../../common_widgets/common_widgets.dart';
import '../neo_manager.dart';

final neoManager = locator<NeoManager>();

class PlayPauseButton extends StatelessWidget {
  final AnimationController animationController;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const PlayPauseButton({
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
      valueListenable: neoManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconBtn(
          icon: Icons.fast_rewind_rounded,
          label: 'previous'.tr(),
          iconSize: 24.0,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(14.0),
          onPressed: (isFirst) ? null : neoManager.skipToPrevious,
        );
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;

  const NextSongButton({
    Key? key,
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.all(8.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: neoManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconBtn(
          icon: Icons.fast_forward_rounded,
          label: 'next'.tr(),
          padding: padding,
          margin: margin,
          iconSize: 24,
          onPressed: (isLast) ? null : neoManager.skipToNext,
        );
      },
    );
  }
}
