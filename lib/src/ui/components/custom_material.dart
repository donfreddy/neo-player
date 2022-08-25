import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SimpleMaterial extends StatelessWidget {
  const SimpleMaterial({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NeumorphicTheme.baseColor(context),
      child: child,
    );
  }
}

class MaterialWitchInkWell extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  const MaterialWitchInkWell({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NeumorphicTheme.baseColor(context),
      child: InkWell(
        // borderRadius: BorderRadius.circular(kRadius),
        focusColor: Colors.transparent,
        //highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.white.withOpacity(0.01),
        splashColor: Colors.white.withOpacity(0.1),
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
