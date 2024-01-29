import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/provider/auth_provider.dart';
import '../../size_config.dart';
import '../widgets/Custom_button.dart';
import '../widgets/custom_pop.dart';
import '../widgets/custom_textformfild.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authRead = context.read<AuthProvider>();
    AuthProvider authWatch = context.read<AuthProvider>();
    SizeConfig().init(context);
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/imgloc.png'),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormFiled(
                label: 'Your Name',
                onSaved: (val) => authWatch.name = val,
                onChanged: (val) => authRead.onChangeName(val),
                validator: validatorName,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormFiled(
                label: 'Your Phone',
                onSaved: (val) => authWatch.phone = val,
                onChanged: (val) => authRead.onChangePhone(val),
                boardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: validatorPhone,
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
              'Sign In',
              onPress: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (!_globalKey.currentState!.validate()) {
                  debugPrint('Error--> validate');
                  return;
                } else if (_globalKey.currentState!.validate()) {
                  final User? authData =
                      await authRead.authAnonymously(context);

                  if (authData == null) {
                    debugPrint('Error--> Signing in');
                  } else {
                    debugPrint('User Auth: $authData');
                  }
                } else {
                  debugPrint('Error---------');
                }
              },
              color: Colors.deepOrange,
            ),
            const SizedBox(height: 10),
            authWatch.isPushData
                ? CustomPOP().loadingWidget()
                : const SizedBox(),
          ],
        ),
      )),
    ));
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  validatorName(val) {
    if (val.isEmpty) {
      return 'Enter your name';
    } else {
      return _globalKey.currentState!.save();
    }
  }

  validatorPhone(val) {
    if (val.isEmpty) {
      return 'Enter your phone';
    } else {
      return _globalKey.currentState!.save();
    }
  }
}
