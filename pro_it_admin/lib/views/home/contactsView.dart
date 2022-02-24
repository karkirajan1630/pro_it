import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pro_it_admin/controllers/controllers.dart';
import 'package:pro_it_admin/models/models.dart';
import 'package:pro_it_admin/utilities/utils.dart';

class ContactsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ContactController>(
        builder: (controller) {
          if (controller.contactsList.isEmpty) {
            return Center(
              child: Text("No Contacts"),
            );
          }
          return ListView.builder(
            itemCount: controller.contactsList.length,
            itemBuilder: (_, i) {
              Contact contact = controller.contactsList[i];
              return Slidable(
                startActionPane: ActionPane(
                  children: [
                    SlidableAction(
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      onPressed: (_) async {
                        await controller.deleteContact(contact);
                      },
                    ),
                  ],
                  motion: StretchMotion(),
                ),
                endActionPane: ActionPane(
                  children: [
                    SlidableAction(
                      label: "Call",
                      icon: Icons.call,
                      backgroundColor: Colors.blue,
                      onPressed: (_) {
                        final Uri phoneLaunchUri = Uri(
                          scheme: 'tel',
                          path: "${contact.number}",
                        );
                        controller.callUser(phoneLaunchUri.toString());
                      },
                    ),
                    SlidableAction(
                      label: "Email",
                      icon: Icons.email,
                      backgroundColor: Colors.green,
                      onPressed: (_) {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: "${contact.email}",
                        );
                        controller.mailUser(emailLaunchUri.toString());
                      },
                    ),
                  ],
                  motion: StretchMotion(),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text("${Utils.getInitials(contact.name)}"),
                  ),
                  title: Text("${contact.name}"),
                  subtitle: Text("${contact.message}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
