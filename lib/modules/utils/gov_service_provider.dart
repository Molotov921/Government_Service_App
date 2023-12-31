import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GovServiceProvider extends ChangeNotifier {
  String selectedService = "";

  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;

  GovServiceProvider() {
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.blue),
      onRefresh: () {
        inAppWebViewController?.reload();
      },
    );
  }

  void updateSelectedService(String service) {
    selectedService = service;
    notifyListeners();
  }

  String getSelectedService() {
    return selectedService;
  }
}
