import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../common_widgets/modal_bottom_item.dart';
import '../../common_widgets/top_bottom_sheet_bar.dart';
import '../../constants/constants.dart';
import '../../helpers/url_launcher.dart';

class HelpFeedback extends StatelessWidget {
  const HelpFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TopBottomSheetBar(),
        ModalBottomItem(
          icon: Icons.contact_support_rounded,
          title: 'Contact us',
          onTap: () {
            launchEmail(subject: 'Feedback');
          },
        ),
        ModalBottomItem(
          icon: Icons.maps_ugc_rounded,
          title: 'Request a feature',
          onTap: () {
            launchEmail(subject: '$kAppName Feature Request');
          },
        ),
        ModalBottomItem(
          icon: Icons.bug_report_rounded,
          title: 'Report a Bug',
          onTap: () {
            launchEmail(
              subject: '$kAppName Feature issue/Bug report',
              body:
                  'Please include details like phone type, Android version, steps to reproduce the issue.',
            );
          },
        ),
      ],
    );
  }
}
