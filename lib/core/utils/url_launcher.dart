import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url);

  try {
    await launchUrl(
      uri,
      //mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    log('Could not launch: $e => $url');
  }
}
