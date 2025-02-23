import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms of Use")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text("Здесь будет текст условий использования..."),
      ),
    );
  }
}
