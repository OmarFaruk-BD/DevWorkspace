import 'package:flutter/material.dart';
import 'package:workspace/core/service/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AppHtmlText extends StatelessWidget {
  const AppHtmlText({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      text ?? '<p> </p>',
      onTapUrl: (url) async {
        await UrlLaunchService.launchURL(url);
        return true;
      },
    );
  }
}
