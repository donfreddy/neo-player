import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class LanguageItem extends StatefulWidget {
  final String languageName;
  final String languageCode;

  const LanguageItem({
    Key? key,
    required this.languageName,
    required this.languageCode,
  }) : super(key: key);

  @override
  State<LanguageItem> createState() => _LanguageItemState();
}

class _LanguageItemState extends State<LanguageItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NeumorphicCheckbox(
          padding: const EdgeInsets.all(4),
          value: context.locale == Locale(widget.languageCode),
          onChanged: (locale) {
            setState(() {
              context.setLocale(Locale(widget.languageCode));
            });
          },
          style: const NeumorphicCheckboxStyle(),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.languageName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.languageName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
