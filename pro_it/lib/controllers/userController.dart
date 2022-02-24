import 'package:get/get.dart';
import 'package:pro_it/config/constants.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/models/dbUser.dart';
import 'package:pro_it/services/firebaseApi.dart';
import 'package:pro_it/utilities/utls.dart';

class UserController extends GetxController {
  Rx<DbUser> dbUser = Rx<DbUser>(
    DbUser(
      name: "Marketing proo",
      username: "marketingpro.london",
      number: null,
      profilePhoto: CIRCULARAPPLOGO,
      email: "marketingpro.london@gmail.com",
    ),
  );

  getDbUser(String username)async{
    dbUser.value = await FirebaseApi.getDbUserById(username);
    print("DbUser: ${dbUser.value.name}");
    update();
  }

  @override
  void onInit() {
    String username = Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);
    getDbUser(username);
    super.onInit();
  }
}
