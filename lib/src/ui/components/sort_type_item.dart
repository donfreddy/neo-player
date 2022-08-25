import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/ui/components/custom_material.dart';

import '../../constants/constants.dart';

class SortTypeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function()? onSortSelect;

  const SortTypeItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.isSelected,
    this.onSortSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(kRadius)),
        ),
        disableDepth: !isSelected,
      ),
      child: MaterialWitchInkWell(
        onTap: onSortSelect,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18.0,
                color: isSelected ? theme.primaryColor : null,
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: isSelected ? theme.primaryColor : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
