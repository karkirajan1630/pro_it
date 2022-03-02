import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:pro_it/config/key.dart';
import 'package:pro_it/config/pallete.dart';
import 'bindings/bindings.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: KHALTIAPIKEY,
        builder: (context, navKey) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Pro IT",
            navigatorKey: navKey,
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            theme: ThemeData(
              primaryColor: Pallete.primaryCol,
              backgroundColor: Pallete.backgroundColor,
            ),
            initialBinding: InitialBinding(),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        });
  }
}
