import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_it/config/userState.dart';
import 'package:pro_it/models/models.dart';
import 'package:pro_it/services/services.dart';
import 'package:pro_it/utilities/utls.dart';

import 'controllers.dart';

class FirebaseAuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Rx<User?>? _firebaseUser;

  Rx<Status> _status = Rx<Status>(Status.UNINITIALIZED);

  Status get status => _status.value;

  // User? get fUser => _firebaseUser!.value;

  User? get user => _auth.currentUser;

  @override
  void onInit() {
    _firebaseUser?.bindStream(_auth.authStateChanges());

    print(" Auth Change :   ${_auth.currentUser}");

    if (_auth.currentUser == null) {
      print("User is not logged in");
      _status.value = Status.UNAUTHENTICATED;

      update();
    } else {
      print("User is logged in");

      _status.value = Status.AUTHENTICATED;
      update();
    }
    super.onInit();
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      _status.value = Status.AUTHENTICATING;
      update();
      String username = Utils.getUsername(email);
      print(
          "Sign Up with:{username:$username,name:$name,email:$email,password:$password}");
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential uCreds) async {
          DbUser dbuser = DbUser(
            name: name,
            profilePhoto: "",
            email: uCreds.user!.email.toString(),
            username: username,
          );
          await FirebaseApi.createDbUserById(dbuser);
          await signIn(email, password);
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackMessage(e.code);
      _status.value = Status.UNAUTHENTICATED;
      update();
    }
     catch (e) {
      Utils.showSnackBar("Error!!!", "${e.toString()}");
      _status.value = Status.UNAUTHENTICATED;
      update();
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _status.value = Status.AUTHENTICATING;
      update();
      print("Sign In with:{email:$email,password:$password}");
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (UserCredential uCreds) {
          print(uCreds);
          _status.value = Status.AUTHENTICATED;
          update();
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackMessage(e.code);
      _status.value = Status.UNAUTHENTICATED;
      update();
    } catch (e) {
      Utils.showSnackBar("Error!!!", "${e.toString()}");
      _status.value = Status.UNAUTHENTICATED;
      update();
    }
  }

  // For Android - Login with google
  Future<void> signInWithGoogle() async {
    try {
      // Changing the status to authenticating
      _status.value = Status.AUTHENTICATING;

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Throw an error when the user cancels the google login
      if (googleUser == null) {
        throw "Google Sign In Cancelled";
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((UserCredential uCreds) async {
        DbUser dbuser = DbUser(
            name: uCreds.user!.displayName.toString(),
            profilePhoto: uCreds.user!.photoURL.toString(),
            email: uCreds.user!.email.toString(),
            username: Utils.getUsername(uCreds.user!.email.toString()));
        await FirebaseApi.createDbUserById(dbuser);
        _status.value = Status.AUTHENTICATED;
      });
    } on FirebaseAuthException catch (e) {
      showSnackMessage(e.code);
      _status.value = Status.UNAUTHENTICATED;
    } on PlatformException catch (e) {
      if(e.code == "sign_in_canceled"){
        Utils.showSnackBar("Sorry!!!", "${e.message}");
      }
      
      _status.value = Status.UNAUTHENTICATED;
      update();
    } catch (e) {
      Utils.showSnackBar("Sorry!!!", "${e.toString()}");
      _status.value = Status.UNAUTHENTICATED;
      update();
    }
  }


  // For logout from the app
  Future<void> signOut() async {
    try {
      _auth.signOut();
      googleSignIn.signOut();
      _status.value = Status.UNAUTHENTICATED;
      Get.delete<UserController>(force: true);
      Get.delete<ProductController>(force: true);
      Get.delete<CartController>(force: true);
      Get.delete<OrderController>(force: true);
      update();
    } catch (e) {
      Utils.showSnackBar("Error!!!", "${e.toString()}");
      _status.value = Status.AUTHENTICATED;
      update();
    }
  }

  void showSnackMessage(String code) {
    switch (code) {
      case "account-exists-with-different-credential":
        Utils.showSnackBar(
            "Sorry!!!", "Already exists an account with the email address");
        break;
      case "invalid-credential":
        Utils.showSnackBar(
            "Sorry!!!", "Your credential is malformed or has expired");
        break;
      case "operation-not-allowed":
        Utils.showSnackBar(
            "Sorry its not you!!!", "Google sign In is not enabled");
        break;
      case "email-already-in-use":
        Utils.showSnackBar(
            "Sorry!!!", "The email provided is already exists");
        break;
      case "invalid-email":
        Utils.showSnackBar(
            "Sorry!!!", "Your email is invalid");
        break;
      case "weak-password":
        Utils.showSnackBar(
            "Sorry!!!", "Your password is too weak");
        break;
      case "user-disabled":
        Utils.showSnackBar("Sorry!!!", "Your account has been disabled");
        break;
      case "user-not-found":
        Utils.showSnackBar("Sorry!!!", "Your account cannot be found");
        break;
      case "wrong-password":
        Utils.showSnackBar("Sorry!!!", "Your provided password is invalid");
        break;
      case "invalid-verification-code":
        Utils.showSnackBar("Sorry!!!", "Your verification code is invalid");
        break;
      case "invalid-verification-id":
        Utils.showSnackBar("Sorry!!!", "Your verification id is invalid");
        break;
      default:
        Utils.showSnackBar("Sorry!!!", "Something went wrong. Try again");
    }
  }
}
