import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SmallBtn extends StatelessWidget {
  final IconData icon;
  final double depth;
  final Color color;
  final void Function()? onPressed;

  const SmallBtn({
    Key? key,
    required this.icon,
    this.onPressed,
    this.depth = 2.0,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: const EdgeInsets.all(4.0),
      onPressed: onPressed,
      style: NeumorphicStyle(
        depth: depth,
        shape: NeumorphicShape.flat,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      child: Icon(
        icon,
        size: 20.0,
        color: color,
      ),
    );
  }
}
