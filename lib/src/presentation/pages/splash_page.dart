import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  void _loadSongs() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
