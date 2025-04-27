import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:workspace/core/api/endpoints.dart';

class UrlLaunchService {
  Future<void> launchURL(String urlPath) async {
    final Uri url = Uri.parse(urlPath);
    if (!await launchUrl(url)) {
      Logger().e('Could not launch $url');
    }
  }

  Future<void> openDocument(String? endpoint) async {
    String fullPath = '${Endpoints.baseURL}/$endpoint';
    final Uri url = Uri.parse(fullPath);
    Logger().e(url);
    Logger().e(endpoint);
    Logger().e(fullPath);
    if (!await launchUrl(url)) {
      Logger().e('Could not launch $url');
    }
  }
}
