import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignInWebView extends StatefulWidget {
  final Function(Uri url) authCodeUrl;
  const SignInWebView({
    super.key,
    required this.authCodeUrl,
  });

  @override
  State<SignInWebView> createState() => _SignInWebViewState();
}

class _SignInWebViewState extends State<SignInWebView> {
  late WebViewController webViewController;
  late Uri getAuthorizationToken;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Uri getAuthorizationUrl() {
    const clientId = 'sq0idp-2fQOp6SD7KXTB2iTH50wkw';
    final authorizeUrl =
        Uri.https('connect.squareup.com', '/oauth2/authorize', {
      'client_id': clientId,
      'scope': 'MERCHANT_PROFILE_READ',
      'state': 'https://backslashflutter.github.io/square_redirect_page',
      'session': 'false',
    });
    return authorizeUrl;
  }

  void loadData() async {
    try {
      getAuthorizationToken = getAuthorizationUrl();
      webViewController = WebViewController()
        ..loadRequest(getAuthorizationToken)
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onUrlChange: (change) {
            if (change.url != null) {
              Uri uri = Uri.parse(change.url!);
              if (uri.path == '/square_redirect_page/') {
                if (uri.queryParameters.containsKey('code') &&
                    uri.queryParameters['response_type'] == 'code') {
                  widget.authCodeUrl(uri);
                }
              }
            }
          },
        ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.9,
        child: WebViewWidget(
          controller: webViewController,
        ));
  }
}
