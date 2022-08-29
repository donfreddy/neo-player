import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SettingCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLeft;
  final void Function()? onPressed;

  const SettingCard({
    Key? key,
    required this.icon,
    required this.text,
    this.isLeft = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: isLeft
          ? const EdgeInsets.fromLTRB(16, 0, 10, 0)
          : const EdgeInsets.fromLTRB(10, 0, 16, 0),
      child: NeumorphicButton(
        onPressed: onPressed,
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.all(Radius.circular(10)),
          ),
          depth: 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: NeumorphicTheme.defaultTextColor(context)),
            const Spacer(),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
