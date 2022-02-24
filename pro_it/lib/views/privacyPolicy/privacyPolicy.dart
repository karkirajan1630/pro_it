import 'package:flutter/material.dart';
import 'package:pro_it/widgets/widgets.dart';

class PrivacyPolicy extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: MarkdownView(
        path: "assets/markDown/privacy-policy.md",
      ),
    );
  }
}


