import 'package:get/get.dart';
import 'package:pro_it/controllers/controllers.dart';

class InitialBinding implements Bindings {
@override
void dependencies() {
    Get.put<FirebaseAuthController>(FirebaseAuthController());
  }
}