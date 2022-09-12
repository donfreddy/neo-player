import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../../../constants/constants.dart';
import '../../../theme/style.dart';
import '../neo_manager.dart';

class SeekBar extends StatefulWidget {
  final double barHeight;

  const SeekBar({super.key, required this.barHeight});

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  bool _dragging = false;

  void _onDrag(double value) {
    if (!_dragging) {
      _dragging = true;
    }
    setState(() {
      _dragValue = value;
    });
  }

  void _onDragEng(double value) {
    locator<NeoManager>().seek(Duration(milliseconds: value.round()));
    _dragging = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: locator<NeoManager>().progressNotifier,
      builder: (_, progressValue, __) {
        final value = min(
          _dragValue ?? progressValue.current.inMilliseconds.toDouble(),
          progressValue.total.inMilliseconds.toDouble(),
        );
        return SizedBox(
          height: widget.barHeight,
          child: Stack(
            children: [
              NeumorphicSlider(
                value: value,
                height: 3,
                max: progressValue.total.inMilliseconds.toDouble(),
                style: const SliderStyle(depth: -kDepth),
                thumb: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    depth: kDepth,
                    color: theme.primaryColor,
                    boxShape: const NeumorphicBoxShape.circle(),
                  ),
                  child: AnimatedContainer(
                    duration: kShortDuration,
                    height: _dragging
                        ? widget.barHeight * 0.5
                        : widget.barHeight * 0.2,
                    width: _dragging
                        ? widget.barHeight * 0.5
                        : widget.barHeight * 0.2,
                  ),
                ),
                onChangeStart: _onDrag,
                onChanged: _onDrag,
                onChangeEnd: _onDragEng,
              ),
              Positioned(
                left: 0,
                bottom: widget.barHeight / 50,
                child: Text(
                  _getTimeString(progressValue.current),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: textGrayColor,
                    fontSize: widget.barHeight / 4,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: widget.barHeight / 50,
                child: Text(
                  '-${_getTimeString(progressValue.total - progressValue.current)}',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: textGrayColor,
                    fontSize: widget.barHeight / 4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTimeString(Duration time) {
    final minutes =
        time.inMinutes.remainder(Duration.minutesPerHour).toString();
    final seconds = time.inSeconds
        .remainder(Duration.secondsPerMinute)
        .toString()
        .padLeft(2, '0');
    return time.inHours > 0
        ? "${time.inHours}:${minutes.padLeft(2, "0")}:$seconds"
        : '$minutes:$seconds';
  }
}
