import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLaunchService {
  static Future<void> launchURL(String urlPath) async {
    try {
      if (!urlPath.startsWith('http://') && !urlPath.startsWith('https://')) {
        urlPath = 'https://$urlPath';
      }
      final Uri url = Uri.parse(urlPath);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        Logger().e('Failed to launch $url');
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
