import 'package:get/get.dart';
import 'package:pro_it/controllers/controllers.dart';

class WrapperBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NavController>(NavController());
    Get.put<HomeController>(HomeController());
    
  }
}
