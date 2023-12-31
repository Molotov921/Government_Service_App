import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gov_service_app/modules/utils/gov_service_provider.dart';
import 'package:gov_service_app/modules/view/hompage/model/all_gov_service_model.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var govServiceData =
        ModalRoute.of(context)!.settings.arguments as GovServiceData;
    var govServiceProvider = Provider.of<GovServiceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(govServiceData.name),
      ),
      bottomNavigationBar: Container(
        height: 65,
        width: double.infinity,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () async {
                  var controller = govServiceProvider.inAppWebViewController!;
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  }
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () async {
                  var controller = govServiceProvider.inAppWebViewController!;
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                  }
                },
                icon: const Icon(Icons.arrow_forward),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () async {
                  var controller = govServiceProvider.inAppWebViewController!;
                  await controller.reload();
                },
                icon: const Icon(Icons.refresh),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () async {
                  govServiceProvider.updateSelectedService(govServiceData.name);

                  var controller = govServiceProvider.inAppWebViewController!;
                  await controller.loadUrl(
                    urlRequest: URLRequest(
                      url: WebUri(govServiceData.link),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: InAppWebView(
        pullToRefreshController: govServiceProvider.pullToRefreshController,
        initialUrlRequest: URLRequest(
          url: WebUri(govServiceData.link),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          govServiceProvider.inAppWebViewController = controller;
        },
        onLoadStop: (controller, uri) async {
          await govServiceProvider.pullToRefreshController?.endRefreshing();
        },
      ),
    );
  }
}
