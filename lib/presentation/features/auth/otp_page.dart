import 'package:flutter/material.dart';

class OTPPage extends StatelessWidget {
  final String phoneNumber;

  const OTPPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(phoneNumber),
      ),
    );
  }
}
