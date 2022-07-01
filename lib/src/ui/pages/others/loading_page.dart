import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../locator.dart';
import '../../../theme/theme.dart';
import '../../../constants/constants.dart';
import '../../../provider/song_provider.dart';
import '../../../routes/route_constants.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final SongProvider songProvider = locator<SongProvider>();

  @override
  void initState() {
    super.initState();
    _getStoragePermission();
  }

  Future _getStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      await checkSong();
    } else if (status.isPermanentlyDenied) {
      if (!mounted) return;
      Navigator.pushNamed(context, storagePermissionRoute, arguments: true);
    } else if (status.isDenied) {
      if (!mounted) return;
      Navigator.pushNamed(context, storagePermissionRoute, arguments: false);
    }
  }

  Future<void> checkSong() async {
    if (await songProvider.hasSong()) {
      Navigator.pushReplacementNamed(context, notFoundSongRoute);
    }
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, mainRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: screenHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  child: NeumorphicText(
                    Constants.appName,
                    style: NeumorphicStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 50.0,
                      fontFamily: Constants.fontFamily,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              //const SizedBox(height: 80),
              Expanded(
                child: SpinKitWave(
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
