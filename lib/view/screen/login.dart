import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/login_controller.dart';
import 'package:getx_ecommerce_dashboard/core/enums/validated_input_type.dart';
import 'package:getx_ecommerce_dashboard/core/functions/functions.dart';
import 'package:getx_ecommerce_dashboard/view/widget/auth/custom_auth_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/auth/custom_textformfield.dart';
import 'package:getx_ecommerce_dashboard/view/widget/auth/custom_title.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';
import 'package:getx_ecommerce_dashboard/view/widget/loading.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<LoginController>(
          builder: (controller) {
            return Center(
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                children: [
                  Form(
                    key: controller.formKey,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 18.0,
                          horizontal: 16,
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const CustomAuthTitleText(
                              "Welcome Admin",
                              "login with email and password to continue",
                            ),

                            const GapH(50),
                            CustomTextFormField(
                              labelText: "Email",
                              hintText: "Email",
                              icon: Icons.email_outlined,
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                return AppFunctions.validateField(
                                  val,
                                  inputType: ValidatedInputType.email,
                                );
                              },
                            ),
                            const SizedBox(height: 25),
                            CustomTextFormField(
                              labelText: "Password",
                              hintText: "Password",
                              icon: controller.isShowPassword.value
                                  ? Icons.lock_open_outlined
                                  : Icons.lock_outlined,
                              controller: controller.passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !controller.isShowPassword.value,
                              onTapIcon: () {
                                controller.isShowPassword.toggle();
                              },
                              validator: (val) {
                                return AppFunctions.validateField(
                                  val,
                                  inputType: ValidatedInputType.other,
                                );
                              },
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     TextButton(
                            //       onPressed: () {
                            //         // Get.toNamed(AppRoutes.forgotPassword);
                            //       },
                            //       style: ButtonStyle(
                            //         overlayColor: MaterialStateProperty.all(
                            //           Get.theme.primaryColor.withOpacity(.1),
                            //         ),
                            //         foregroundColor: MaterialStateProperty.all(
                            //           // Get.theme.primaryColor,
                            //           Colors.black54,
                            //         ),
                            //       ),
                            //       child: const Text(
                            //         "Forgot Password",
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const GapH(30),
                            controller.isLoading.value
                                ? const Loading()
                                : CustomAuthButton(
                                    text: "Login",
                                    onPressed: () {
                                      controller.login();
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
