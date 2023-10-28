import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../constants/constants.dart';
import 'common_widgets.dart';

class OrderTypeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final int value;
  final bool isSelected;
  final void Function(int value)? onOrderSelect;

  const OrderTypeItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.value,
    required this.isSelected,
    this.onOrderSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Neumorphic(
      margin: const EdgeInsets.all(5.0),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(kRadius)),
        ),
        disableDepth: !isSelected,
      ),
      child: MaterialWitchInkWell(
        onTap: () => onOrderSelect!(value),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? theme.primaryColor : null,
              ),
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
