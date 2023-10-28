import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../components/icon_btn.dart';

class ArtistDetailPage extends StatefulWidget {
  final ArtistModel artist;
  final int mode;

  const ArtistDetailPage({
    Key? key,
    required this.artist,
    required this.mode,
  }) : super(key: key);

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: IconBtn(
            icon: Icons.arrow_back_rounded,
            label: 'Back',
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          widget.artist.artist,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text("artiste detail"),
            ],
          ),
        ],
      ),
    );
  }
}
