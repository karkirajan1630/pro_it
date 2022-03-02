import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/config/constants.dart';
import 'package:pro_it_admin/controllers/controllers.dart';
import 'package:pro_it_admin/models/models.dart';
import 'package:pro_it_admin/services/firebaseApi.dart';
import 'package:pro_it_admin/utilities/utils.dart';

class ChatMessageController extends GetxController {
  var chatScaffoldKey = GlobalKey<ScaffoldState>();

  final Rx<List<ChatMessage>> _chatMessageList = Rx<List<ChatMessage>>([]);

  List<ChatMessage> get chatMessageList => _chatMessageList.value;

  var message = TextEditingController().obs;

  var username = "".obs;

  @override
  void onInit() {
    username.value = Get.arguments['id']!;
    print(username.value);
    _chatMessageList.bindStream(FirebaseApi.getAllChatMessages(username.value));
    super.onInit();
  }

  Future<void> deleteAllChatMessages() async {
    for (var item in _chatMessageList.value) {
      await FirebaseApi.deleteChatMessage(username.value, item.id!);
    }
  }

  Future<void> deleteChatMessageItem(String id) async {
    await FirebaseApi.deleteChatMessage(username.value, id);
  }

  sendMessageByAdmin(ChatUser chatUser) async {
    try {
      if (message.value.text.isEmpty) {
        FocusScope.of(chatScaffoldKey.currentState!.context)
            .requestFocus(FocusNode());
        return;
      }
      ConnectivityResult connectivity =
          await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        throw "Check your internet connection";
      }
      ChatMessage chatMessage = ChatMessage(
        message: message.value.text,
        senderId: AdminUsername,
        receiverId: username.value,
        updateDate: DateTime.now(),
      );
      await FirebaseApi.createChatMessage(username.value, chatMessage)
          .then((value) {
        Get.find<ChatController>().setLastMessage(chatUser, message.value.text);
        FocusScope.of(chatScaffoldKey.currentState!.context)
            .requestFocus(FocusNode());
        message.value.text = "";
        update();
      });
    } catch (e) {
      Utils.showSnackBar("Sorry!!!", e.toString());
    }
  }
}
