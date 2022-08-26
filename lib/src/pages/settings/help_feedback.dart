import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../constants/constants.dart';
import '../../helpers/url_launcher.dart';

class HelpFeedback extends StatelessWidget {
  const HelpFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.pop(context);
            launchEmail(subject: 'Feedback');
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20.0),
            child: const Text(
              'Nous contacter',
            ),
          ),
        ),
        InkWell(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20.0),
            child: const Text(
              'Demander une fonctionnalité',
            ),
          ),
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.pop(context);
            launchEmail(subject: '$kAppName Feature Request');
          },
        ),
        InkWell(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20.0),
            child: const Text('Signaler un probleme'),
          ),
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.pop(context);
            launchEmail(
              subject: '$kAppName Feature issue/Bug report',
              body:
                  'Please include details like phone type, Android version, steps to reproduce the issue.',
            );
          },
        ),
        InkWell(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 20.0),
            child: const Text(
              'Signaler une erreur de traduction',
            ),
          ),
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.pop(context);
            launchEmail(subject: '$kAppName Translation Error');
          },
        ),
      ],
    );
  }
}
