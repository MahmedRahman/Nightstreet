import 'package:url_launcher/url_launcher.dart';

Future<void> urlLauncher(String uri) async {
  final Uri _url = Uri.parse(uri);
  if (await canLaunchUrl(_url)) {
    await launchUrl(_url, mode: LaunchMode.inAppWebView);
  } else {
    throw 'Could not launch $_url';
  }
}
