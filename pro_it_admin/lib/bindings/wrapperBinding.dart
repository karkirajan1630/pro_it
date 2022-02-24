import 'package:get/get.dart';
import 'package:pro_it_admin/controllers/controllers.dart';

class WrapperBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NavController>(NavController());
  Get.put<ProductController>(ProductController());
  Get.put<ContactController>(ContactController());
  Get.put<OrderController>(OrderController());
  Get.put<ChatController>(ChatController());
    
  }
}
