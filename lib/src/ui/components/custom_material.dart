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
  const MaterialWitchInkWell({
    required this.child,
    required this.onTap,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NeumorphicTheme.baseColor(context),
      child: InkWell(
        // borderRadius: BorderRadius.circular(kRadius),
        focusColor: Colors.transparent,
        //highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.black.withOpacity(0.01),
        splashColor: Colors.black.withOpacity(0.1),
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
