import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SortItem {
  final IconData icon;
  final String title;

  SortItem({required this.icon, required this.title});
}

final List<SortItem> songSortItems = [
  SortItem(icon: Icons.title, title: 'title'.tr()),
  SortItem(icon: Icons.person_outline, title: 'artist'.tr()),
  SortItem(icon: Icons.album_outlined, title: 'Album'.tr()),
  SortItem(icon: Icons.schedule_outlined, title: 'duration'.tr()),
  SortItem(icon: Icons.calendar_today_outlined, title: 'date_added'.tr()),
  SortItem(icon: Icons.dns_outlined, title: 'size'.tr()),
  SortItem(icon: Icons.text_fields_outlined, title: 'display_name'.tr()),
];

final List<SortItem> artistSortItems = [
  SortItem(icon: Icons.person_outline, title: 'artist'.tr()),
  SortItem(icon: Icons.music_note_outlined, title: 'number_of_songs'.tr()),
  SortItem(icon: Icons.album_outlined, title: 'number_of_albums'.tr()),
];

final List<SortItem> orderItems = [
  SortItem(icon: Icons.expand_less_rounded, title: 'ascending'.tr()),
  SortItem(icon: Icons.expand_more_rounded, title: 'descending'.tr()),
];
