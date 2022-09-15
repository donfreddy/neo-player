import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../../../constants/constants.dart';
import '../neo_manager.dart';

class VolumeSlider extends StatelessWidget {
  final double barHeight;

  const VolumeSlider({
    Key? key,
    required this.barHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: barHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.volume_down_rounded, size: 20),
          Expanded(
            child: ValueListenableBuilder<double>(
              valueListenable: locator<NeoManager>().volumeNotifier,
              builder: (_, volumeValue, __) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: NeumorphicSlider(
                    value: volumeValue,
                    height: 2,
                    max: 1,
                    onChanged: (volume) {
                      locator<NeoManager>().setVolume(volume);
                    },
                    style: const SliderStyle(depth: -kDepth),
                    thumb: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        depth: kDepth,
                        color: theme.primaryColor,
                        boxShape: const NeumorphicBoxShape.circle(),
                      ),
                      child: SizedBox(
                        height: barHeight,
                        width: barHeight,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Icon(Icons.volume_up_rounded, size: 20),
        ],
      ),
    );
  }
}
