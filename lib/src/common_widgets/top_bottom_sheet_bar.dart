import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neo_player/src/theme/style.dart';

class TopBottomSheetBar extends StatelessWidget {
  const TopBottomSheetBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 4.5,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: textGrayColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 45,
      ),
    );
  }
}
