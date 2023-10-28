import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../locator.dart';
import '../../constants/constants.dart';
import '../../provider/song_provider.dart';
import '../../routes/route_constants.dart';
import '../../theme/theme.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final audioQuery = locator<OnAudioQuery>();
  final songProvider = locator<SongProvider>();

  @override
  void initState() {
    super.initState();
    _getStoragePermission();
  }

  Future _getStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      await loadSongs();
      checkSongAndNavigate();
    } else if (status.isPermanentlyDenied) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, storagePermissionRoute,
          arguments: true);
    } else if (status.isDenied) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, storagePermissionRoute,
          arguments: false);
    }
  }

  void _requestPermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
    setState(() {});
  }

  // Load tracks from user devices
  Future<void> loadSongs() async {
    await songProvider.getSongs();
    await songProvider.getArtists();
    await songProvider.getAlbums();
    await songProvider.getAlbums();
    await songProvider.getGenres();
  }

  // Check if actual device has one or more tracks
  void checkSongAndNavigate() {
    if (!songProvider.hasSong) {
      Navigator.pushReplacementNamed(context, notFoundSongRoute);
    } else {
      Navigator.pushReplacementNamed(context, mainRoute);
    }
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
                    kAppName,
                    style: NeumorphicStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 50.0,
                      fontFamily: kNunitoFont,
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
