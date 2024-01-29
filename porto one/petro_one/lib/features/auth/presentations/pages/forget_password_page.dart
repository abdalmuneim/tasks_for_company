import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petro_one/features/auth/presentations/controllers/forget_password_controller.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
        builder: (ForgetPasswordController controller) {
      return const Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Text('data'),
        ),
      );
    });
  }
}
