import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class UnSelectSort extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? function;

  const UnSelectSort({
    Key? key,
    required this.title,
    required this.icon,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
            const SizedBox(width: 10),
            Text(title, style: theme.textTheme.bodyLarge)
          ],
        ),
      ),
    );
  }
}
