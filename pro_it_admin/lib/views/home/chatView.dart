import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/bindings/bindings.dart';
import 'package:pro_it_admin/controllers/controllers.dart';
import 'package:pro_it_admin/models/models.dart';
import 'package:pro_it_admin/services/firebaseApi.dart';
import 'package:pro_it_admin/widgets/widgets.dart';
import '../chat/chatMessageView.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ChatController>(builder: (controller) {
        if(controller.chatUserList.isEmpty){
           return Center(
              child: Text("No Chats"),
            );
        }
        return ListView.builder(
            itemCount: controller.chatUserList.length,
            itemBuilder: (_, i) {
              ChatUser chatUser = controller.chatUserList[i];
              return Slidable(
                endActionPane: ActionPane(
                  children: [
                    SlidableAction(
                    label: "Delete",
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    onPressed: (_) async {
                      Get.defaultDialog(
                        title: "Do you want to delete?",
                        backgroundColor: Colors.red,
                        middleText: "This will delete all of the chats and the user too.",
                        confirm: IconButton(
                          onPressed: () async {
                            await FirebaseApi.deleteChatUser(chatUser);
                            Get.back();
                          },
                          icon: Icon(Icons.done),
                        ),
                        cancel: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.cancel),
                        ),
                      );
                    },
                  ),
                  ],
                  motion: StretchMotion(),
                ),
                child: ListTile(
                  key: Key(chatUser.id!),
                  onTap: () {
                    Get.to(
                        () => ChatMessageView(
                              chatUser: chatUser,
                            ),
                        binding: ChatMessageBinding(),
                        arguments: {"id": "${chatUser.id}"});
                  },
                  leading: UserCircle(
                    key: key,
                    name: chatUser.name,
                    profileImage: chatUser.profileImg,
                  ),
                  title: Text("${chatUser.name}"),
                  subtitle: Text(
                    "${chatUser.lastMessage}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            });
      }),
    );
  }
}
