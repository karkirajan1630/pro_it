import 'package:flutter/material.dart';
import 'package:pro_it/widgets/widgets.dart';

class TermsOfService extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
        centerTitle: true,
      ),
      body: MarkdownView(
        path: "assets/markDown/terms-of-service.md",
      ),
    );
  }
}


