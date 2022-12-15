import 'dart:io';

import 'package:dangoz/base/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CryptoChartScreen extends StatefulWidget {
  @override
  CryptoChartScreenState createState() => CryptoChartScreenState();
}

class CryptoChartScreenState extends State<CryptoChartScreen> {
  final _key = UniqueKey();
  bool is_loading = true;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          key: _key,
          initialUrl:
              'https://www.tradingview.com/chart/?symbol=BITSTAMP%3ABTCUSD',
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finish) {
            setState(() {
              is_loading = false;
            });
          },
        ),
        is_loading
            ? Center(
                child: SpinKitCubeGrid(color: AppColors.navy),
              )
            : Stack(),
      ],
    );
  }
}
