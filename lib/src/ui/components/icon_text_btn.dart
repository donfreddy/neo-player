import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconTextBtn extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;

  const IconTextBtn({
    Key? key,
    required this.icon,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(
            Radius.circular(08.0),
          ),
        ),
        depth: 2
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: NeumorphicTheme.accentColor(context),
          ),
          const SizedBox(width: 10.0),
          Text(
            text,
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: NeumorphicTheme.accentColor(context),
                ),
          ),
        ],
      ),
    );
  }
}
