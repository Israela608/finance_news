import 'dart:developer';

import 'package:finance_news/core/utils/app_colors.dart';
import 'package:finance_news/core/utils/app_styles.dart';
import 'package:finance_news/data/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen(
      {super.key, required this.firstName, required this.url});

  final String firstName;
  final String url;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreen();
}

class _NewsDetailScreen extends State<NewsDetailScreen> {
  late final WebViewController controller;
  int loadingPercentage = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent("Flutter;Webview")
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            log("On page started url : $url");
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (int progress) {
            log("Page progress : $progress");
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (String url) {
            print("On Page finished Url : $url");
            setState(() {
              loadingPercentage = 100;
            });
          },
          onHttpError: (HttpResponseError error) {
            log('HTTP Error => $error');
          },
          onWebResourceError: (WebResourceError error) {
            log('Web Resource Error => $error');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.reload();
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 22.h,
                  bottom: 22.h,
                ),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${Strings.greeting} ${widget.firstName}',
                  textScaler: TextScaler.noScaling,
                  style: AppStyle.titleStyleWhite(context),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    WebViewWidget(controller: controller),
                    if (loadingPercentage < 50)
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primary600,
                          // The circular progress indicator is used to display the circular progress in the center of the screen with the value of the loading of page progress .
                          value: loadingPercentage / 100.0,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
