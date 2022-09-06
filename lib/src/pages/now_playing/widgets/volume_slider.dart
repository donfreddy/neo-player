import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../locator.dart';
import '../../../constants/constants.dart';
import '../neo_manager.dart';

class VolumeSlider extends StatelessWidget {
  final double height;

  const VolumeSlider({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.volume_mute_rounded, size: 20),
        Expanded(
          child: ValueListenableBuilder<double>(
            valueListenable: locator<NeoManager>().volumeNotifier,
            builder: (_, volumeValue, __) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: NeumorphicSlider(
                  value: volumeValue,
                  height: height * 0.06,
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
                      height: height * 0.45,
                      width: height * 0.45,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Icon(Icons.volume_up_rounded, size: 20),
      ],
    );
  }
}
