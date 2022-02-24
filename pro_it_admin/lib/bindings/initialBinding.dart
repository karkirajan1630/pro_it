import 'package:get/get.dart';
import 'package:pro_it_admin/controllers/controllers.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuthController>(FirebaseAuthController());
  }
}
