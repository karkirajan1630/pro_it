import 'package:get/get.dart';
import 'package:pro_it_admin/models/models.dart';
import 'package:pro_it_admin/services/firebaseApi.dart';
import 'package:pro_it_admin/utilities/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {

Rx<List<Contact>> _contactsList = Rx<List<Contact>>([]);


  List<Contact> get contactsList => _contactsList.value;

  @override
  void onInit() {
    
    _contactsList.bindStream(FirebaseApi.getAllContacts());
    super.onInit();
  }

  Future<void> deleteContact(Contact contact) async {
    await FirebaseApi.deleteContact(contact);
  }

  Future<void> callUser(String url) async {
   try{
     if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not make a call';
    }
   }catch(e){
     Utils.showSnackBar("Sorry", e.toString());
   }
  }
  Future<void> mailUser(String url) async {
   try{
     if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not mail';
    }
   }catch(e){
     Utils.showSnackBar("Sorry", e.toString());
   }
  }

  @override
  void dispose() { 
    super.dispose();
  }
}