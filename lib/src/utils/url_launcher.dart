import 'package:flutter/material.dart';
import 'package:neo_player/src/common/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a web url in the device's default browser
Future<void> launchCustomUrl(String url) async {
  final uri = Uri.parse(url);
  final bool canLaunchCustomUrl = await canLaunchUrl(uri);
  if (canLaunchCustomUrl) {
    final bool successful = await launchUrl(uri);
    if (!successful) {
      return Future<void>.error('Failed to launch $url');
    }
  } else {
    return Future<void>.error('Could not launch $url');
  }
}

/// Opens the device's email app with the given optionally a subject and body
Future<void> launchEmail({String? subject, String? body}) async {
  String sub = subject ?? '';
  String content = body ?? '';

  final uri = Uri(
    scheme: 'mailto',
    path: Constants.appEmail,
    query: 'subject=$sub&body=$content',
  );

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    debugPrint('Could not launch ${uri.toString()}');
  }
}
