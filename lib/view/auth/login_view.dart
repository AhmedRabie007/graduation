import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/viewmodel/auth_viewmodel.dart';
import 'register_view.dart';
import '../../constants.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textFormField.dart';
import '../widgets/custom_button.dart';

class LoginView extends GetWidget<AuthViewModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  right: 16.w, left: 16.w, top: 126.h, bottom: 42.h),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Welcome,',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(RegisterView());
                                  },
                                  child: CustomText(
                                    text: 'Sign Up',
                                    fontSize: 18,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              text: 'Sign in to Continue',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 48.h,
                            ),
                            CustomTextFormField(
                              title: 'Email',
                              hintText: 'example@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                              validatorFn: (value) {
                                if (value!.isEmpty)
                                  return 'Email invalid or not found';
                              },
                              onSavedFn: (value) {
                                controller.email = value;
                              },
                            ),
                            SizedBox(
                              height: 38.h,
                            ),
                            CustomTextFormField(
                              title: 'Password',
                              hintText: '***********',
                              obscureText: true,
                              validatorFn: (value) {
                                if (value!.isEmpty)
                                  return 'Password is incorrect';
                              },
                              onSavedFn: (value) {
                                controller.password = value;
                              },
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomText(
                              text: 'Forgot Password?',
                              fontSize: 14,
                              alignment: Alignment.centerRight,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomButton(
                              'SIGN IN',
                              () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  controller.signInWithEmailAndPassword();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

