import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final String? label;
  final Color? color;
  final Color? iconColor;
  final double iconSize;
  final bool isPressed;
  final bool isActive;
  final void Function()? onPressed;

  const IconBtn({
    Key? key,
    required this.icon,
    this.label,
    this.isPressed = false,
    this.onPressed,
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.all(8.0),
    this.iconSize = 20.0,
    this.isActive = false,
    this.color,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: padding,
      margin: margin,
      onPressed: onPressed,
      tooltip: label,
      drawSurfaceAboveChild: false,
      pressed: isPressed,
      style: NeumorphicStyle(
        color: color,
        depth: isActive ? -2 : 2,
        shape: NeumorphicShape.flat,
        boxShape: const NeumorphicBoxShape.circle(),
      ),
      child: Icon(icon,
          size: iconSize,
          color: iconColor ?? Theme.of(context).iconTheme.color),
    );
  }
}
