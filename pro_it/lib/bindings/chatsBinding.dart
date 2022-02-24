import 'package:get/get.dart';
import 'package:pro_it/controllers/controllers.dart';

class ChatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatMessageController>(ChatMessageController());
  }
}
