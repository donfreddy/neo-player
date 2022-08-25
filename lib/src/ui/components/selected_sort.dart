import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SelectedSort extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;

  const SelectedSort({
    Key? key,
    required this.title,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Neumorphic(
      padding: const EdgeInsets.all(10),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(12)),
        ),
        // disableDepth: true,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.primaryColor,
          ),
          const SizedBox(width: 4),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: theme.primaryColor),
          ),
          // const Spacer(),
          // Icon(
          //   Icons.check,
          //   size: 20,
          //   color: theme.primaryColor,
          // ),
        ],
      ),
    );
  }
}
