import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/common_widgets/common_widgets.dart';
import 'package:neo_player/src/constants/constants.dart';

class ModalBottomItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final VoidCallback? onTap;

  const ModalBottomItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialWitchInkWell(
      onTap: () {
        // HapticFeedback.vibrate();
        Navigator.pop(context);
        onTap!();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: kAppContentPadding,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 15),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
