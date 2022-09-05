import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SortItem {
  final IconData icon;
  final String title;

  SortItem({required this.icon, required this.title});
}

final List<SortItem> songSortItems = [
  SortItem(icon: Icons.title, title: 'title'.tr()),
  SortItem(icon: Icons.mic, title: 'artist'.tr()),
  SortItem(icon: Icons.album_rounded, title: 'Album'.tr()),
  SortItem(icon: Icons.schedule_rounded, title: 'duration'.tr()),
  SortItem(icon: Icons.calendar_today, title: 'date_added'.tr()),
  SortItem(icon: Icons.dns_rounded, title: 'size'.tr()),
  SortItem(icon: Icons.text_fields_rounded, title: 'display_name'.tr()),
];

final List<SortItem> orderItems = [
  SortItem(icon: Icons.expand_less_rounded, title: 'ascending'.tr()),
  SortItem(icon: Icons.expand_more_rounded, title: 'descending'.tr()),
];
