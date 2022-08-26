import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AnimatedIconBtn extends StatelessWidget {
  final AnimatedIconData icon;
  final Animation<double> progress;
  final Color bgColor;
  final VoidCallback? onPressed;

  const AnimatedIconBtn({
    Key? key,
    required this.icon,
    this.onPressed,
    required this.bgColor,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: const EdgeInsets.all(20.0),
      onPressed: onPressed,
      style: NeumorphicStyle(
        color: bgColor,
        shape: NeumorphicShape.flat,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      child: AnimatedIcon(
        icon: icon,
        progress: progress,
        color: const Color(0xffdedede),
        /*
        icon,
        size: 40,
        color: darkTextColor, */
      ),
    );
  }
}
