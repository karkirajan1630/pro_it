import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/bindings/bindings.dart';
import 'package:pro_it_admin/config/pallete.dart';
import 'package:pro_it_admin/views/products/editProductView.dart';
import 'package:pro_it_admin/views/views.dart';
import 'package:pro_it_admin/views/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pro IT",
      initialBinding: InitialBinding(),
      theme: ThemeData(
        primaryColor: Pallete.primaryCol,
        backgroundColor: Pallete.backgroundColor,
        
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page:()=> Wrapper(), binding: WrapperBinding()),
        GetPage(name: "/addProduct", page:()=> AddProductView()),
        GetPage(name: "/editProduct/:id", page:()=> EditProductView(), binding: EditProducBinding()),
      ],
    );
  }
}
