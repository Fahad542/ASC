import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Utilis/Widgets/GeneralAppbar.dart';

class LiveStreamWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          CustomAppBar(title: 'YouTube Channel'),
          Expanded(
            child: WebView(
              initialUrl: 'https://www.youtube.com/watch?v=2Ttmy4wjJ1c',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ],
      ),
    );
  }
}
