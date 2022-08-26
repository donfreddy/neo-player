import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/constants/constants.dart';

class SelectedSort extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const SelectedSort({
    Key? key,
    required this.title,
    required this.icon,
    this.isSelected = false, required onSortSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Neumorphic(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 2.0),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(kRadius)),
        ),
        // disableDepth: true,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
