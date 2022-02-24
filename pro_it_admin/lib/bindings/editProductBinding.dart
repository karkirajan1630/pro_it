import 'package:get/get.dart';
import 'package:pro_it_admin/controllers/controllers.dart';

class EditProducBinding implements Bindings {
@override
void dependencies() {
  Get.put<EditProductController>(EditProductController());
  }
}