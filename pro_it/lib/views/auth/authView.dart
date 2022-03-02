import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_it/config/pallete.dart';
import 'package:pro_it/controllers/controllers.dart';
import 'package:pro_it/views/auth/authController.dart';
import 'package:pro_it/widgets/widgets.dart';

import 'signIn.dart';
import 'signUp.dart';

const TextStyle boldText = TextStyle(
  fontWeight: FontWeight.bold,
);

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool? signupForm;
  @override
  void initState() {
    super.initState();
    signupForm = true;
  }

  final AuthController authController =
      Get.put<AuthController>(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              color: Pallete.primaryCol,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: kToolbarHeight - 16.0),
                Container(
                  alignment: Alignment.center,
                  height: (MediaQuery.of(context).size.height / 2) - 150,
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Pallete.primaryCol,
                          offset: Offset(5, 5),
                          blurRadius: 10.0,
                        )
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: ToggleButtons(
                          renderBorder: false,
                          selectedColor: Pallete.primaryCol,
                          fillColor: Colors.transparent,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Sign In",
                                style: boldText,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Sign Up",
                                style: boldText,
                              ),
                            ),
                          ],
                          isSelected: [signupForm!, !signupForm!],
                          onPressed: (index) {
                            setState(() {
                              signupForm = index == 0;
                            });
                          },
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: Duration(
                          milliseconds: 200,
                        ),
                        child: !signupForm! ? SignUp() : SignIn(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Text("Or Connect With"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: OutlinedButton.icon(
                        icon: SVGCircle(
                          svgImage: "assets/images/google.svg",
                          radius: 14,
                        ),
                        label: Text(
                          "GOOGLE",
                          style: TextStyle(color: Pallete.primaryCol),
                        ),
                        onPressed: () {
                          Get.find<FirebaseAuthController>().signInWithGoogle();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
