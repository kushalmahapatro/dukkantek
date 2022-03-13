import 'dart:collection';

import 'package:dukkantek/dukkantek.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webLoader = useState<bool>(false);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        InAppWebView(
          // ignore: prefer_collection_literals
          gestureRecognizers: Set()
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
          initialUrlRequest:
              URLRequest(url: Uri.parse("https://www.dukkantek.com/")),
          initialUserScripts: UnmodifiableListView<UserScript>([]),
          onWebViewCreated: (InAppWebViewController controller) {},
          shouldOverrideUrlLoading: (InAppWebViewController controller,
              NavigationAction navigationAction) async {
            return NavigationActionPolicy.CANCEL;
          },
          onProgressChanged: (controller, progress) {
            if (progress > 80) {
              if (webLoader.value) {
                webLoader.value = false;
              }
            }
          },
          onConsoleMessage: (InAppWebViewController controller,
              ConsoleMessage consoleMessage) {
            debugPrint(consoleMessage.message);
          },
          onUpdateVisitedHistory:
              (InAppWebViewController controller, Uri? u, __) {
            // if (webViewData.stopRedirection ?? false) {
            //   if (u != Uri.parse(webViewData.url)) {
            //     controller.loadUrl(
            //         urlRequest: URLRequest(url: Uri.parse(webViewData.url)));
            //   }
            // }
          },
        ),
        if (webLoader.value)
          Container(
            child: circularProgress(),
          )
      ],
    ));
  }
}
