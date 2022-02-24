import 'package:get/get.dart';
import 'package:pro_it/controllers/contactController.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ContactController>(ContactController());
  }
}
