import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final EdgeInsets margin;
  final String? label;
  final Color? color;
  final Color? iconColor;
  final NeumorphicBoxShape boxShape;
  final bool isPressed;
  final bool isActive;
  final void Function()? onPressed;

  const IconBtn({
    Key? key,
    required this.icon,
    this.label,
    this.isPressed = false,
    this.onPressed,
    this.boxShape = const NeumorphicBoxShape.circle(),
    this.margin = const EdgeInsets.all(8.0),
    this.isActive = false,
    this.color,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      margin: margin,
      onPressed: onPressed,
      tooltip: label,
      drawSurfaceAboveChild: false,
      pressed: isPressed,
      style: NeumorphicStyle(
        color: color,
        depth: isActive ? -2 : 2,
        shape: NeumorphicShape.flat,
        boxShape: boxShape,
      ),
      child: Icon(
        icon,
        size: 26.0,
        color: iconColor,
      ),
    );
  }
}
