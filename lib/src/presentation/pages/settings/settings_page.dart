import 'package:easy_localization/easy_localization.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/shared/style.dart';
import '../../../common/shared/theme.dart';
import '../../bloc/settings/settings.dart';
import '../../components/icon_btn.dart';
import 'components/language_item.dart';
import 'components/setting_card.dart';
import 'help_feedback.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: IconBtn(
            icon: EvaIcons.arrowBackOutline,
            label: 'Back',
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: NeumorphicTheme.defaultTextColor(context),
          ),
        ),
      ),
      body: SizedBox(
        height: screenHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16) +
                  const EdgeInsets.only(bottom: 10),
              child: Neumorphic(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                    const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Column(
                    children: [
                      SwitchListTile(
                        dense: true,
                        value: context.watch<Settings>().isDarkMode,
                        contentPadding: const EdgeInsets.all(0),
                        activeColor: primaryColor,
                        onChanged: (bool dark) {
                          if (dark) {
                            context.read<Settings>().themeMode = ThemeMode.dark;
                          } else {
                            context.read<Settings>().themeMode =
                                ThemeMode.light;
                          }
                        },
                        title: Text(
                          "Dark Mode",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          'Language',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: Text(
                          context.locale == const Locale('en')
                              ? 'English'
                              : 'French',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        onTap: () {
                          HapticFeedback.vibrate();
                          _buildLangModal(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SettingCard(
                    icon: EvaIcons.questionMarkCircleOutline,
                    text: "Help &\nfeedback",
                    onPressed: () {
                      _modalBottom(context);
                    },
                  ),
                ),
                Expanded(
                  child: SettingCard(
                    icon: EvaIcons.personAddOutline,
                    text: "Invite a friend",
                    isLeft: false,
                    onPressed: _shareApp,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (_, snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    return Text(
                      "Version ${snapshot.data?.version} (${snapshot.data?.buildNumber})",
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _buildLangModal(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          backgroundColor: NeumorphicTheme.baseColor(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Center(
            child: Text(
              "Pick a language",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: primaryColor),
            ),
          ),
          titlePadding: const EdgeInsets.all(16),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          children: [
            const Divider(),
            const SizedBox(height: 12),
            const LanguageItem(languageName: 'English', languageCode: 'en'),
            const SizedBox(height: 16),
            const LanguageItem(languageName: 'French', languageCode: 'fr'),
            const SizedBox(height: 12),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                TextButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: primaryColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _shareApp() {
    Share.share(
      'Hey, I am using EasyDo. It\'s a free task management tool. Try it out at https://exemple.com/',
    );
  }
}

void _modalBottom(BuildContext context) {
  showModalBottomSheet<Widget>(
      isScrollControlled: true,
      barrierColor: Colors.black38,
      backgroundColor: NeumorphicTheme.baseColor(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      context: context,
      builder: (_) {
        return const HelpFeedback();
      });
}
