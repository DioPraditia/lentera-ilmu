import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WebViewInformationScreen extends StatefulWidget {
  String title;
  String url;
  WebViewInformationScreen({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  _WebViewInformationScreen createState() => _WebViewInformationScreen();
}

class _WebViewInformationScreen extends State<WebViewInformationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(widget.title),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Get.back(),
            },
          ),
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          // onWebViewCreated: (WebViewController webViewController) {
          //   _controller = webViewController;
          //   _loadHtmlFromAssets();
          // },
        ),
      ),
    );
  }
}
