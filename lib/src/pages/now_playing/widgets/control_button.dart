import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/pages/now_playing/neo_manager.dart';

import '../../../../locator.dart';
import '../../../common_widgets/common_widgets.dart';

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

class Replay10Button extends StatelessWidget {
  const Replay10Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: neoManager.progressNotifier,
      builder: (_, progressValue, __) {
        return IconBtn(
          icon: Icons.replay_10_rounded,
          onPressed: neoManager.replay10,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(4.0),
        );
        //
      },
    );
  }
}

class Forward10Button extends StatelessWidget {
  const Forward10Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: neoManager.progressNotifier,
      builder: (_, progressValue, __) {
        return IconBtn(
          icon: Icons.forward_10_rounded,
          onPressed: neoManager.forward10,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(4.0),
        );
      },
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: neoManager.repeatButtonNotifier,
      builder: (_, value, __) {
        IconData icon;
        Color? color;
        bool isActive;
        switch (value) {
          case RepeatState.off:
            isActive = false;
            icon = Icons.repeat_rounded;
            break;

          case RepeatState.all:
            isActive = true;
            icon = Icons.repeat_rounded;
            color = Theme.of(context).primaryColor;
            break;
          case RepeatState.one:
            isActive = true;
            icon = Icons.repeat_one_rounded;
            color = Theme.of(context).primaryColor;
            break;
        }
        return IconBtn(
          icon: icon,
          onPressed: neoManager.repeat,
          iconColor: color,
          // isActive: isActive,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(4.0),
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: neoManager.isShuffleModeEnabledNotifier,
      builder: (_, isEnabled, __) {
        return IconBtn(
          icon: Icons.shuffle_rounded,
          onPressed: neoManager.shuffle,
          iconColor: isEnabled ? Theme.of(context).primaryColor : null,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.all(4.0),
        );
      },
    );
  }
}
