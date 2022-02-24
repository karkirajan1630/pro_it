import 'package:flutter/material.dart';
import 'package:pro_it/widgets/widgets.dart';

class RefundPolicy extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Policy"),
        centerTitle: true,
      ),
      body: MarkdownView(
        path: "assets/markDown/refund-policy.md",
      ),
    );
  }
}


