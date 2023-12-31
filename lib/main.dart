import 'package:flutter/material.dart';
import 'package:gov_service_app/modules/utils/gov_service_provider.dart';
import 'package:provider/provider.dart';
import 'package:gov_service_app/modules/view/hompage/screen/homepage.dart';
import 'package:gov_service_app/modules/view/hompage/screen/splash_screen.dart';
import 'modules/view/detailpage/screens/detail_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => GovServiceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          '/': (context) => const HomePage(),
          'detail': (context) => const DetailPage(),
          'splash_screen': (context) => const Splash_Screen(),
        },
      ),
    ),
  );
}
