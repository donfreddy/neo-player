import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconBtn extends StatelessWidget {
  final IconData icon;
  final String? label;
  final bool? isPressed;
  final void Function()? onPressed;

  const IconBtn({
    Key? key,
    required this.icon,
    this.label,
    this.isPressed,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      margin: const EdgeInsets.all(8.0),
      onPressed: onPressed,
      tooltip: label,
      pressed: isPressed,
      style: const NeumorphicStyle(
        depth: 2,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: Icon(icon, size: 24.0),
    );
  }
}
