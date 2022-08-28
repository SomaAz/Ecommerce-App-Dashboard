import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/core/functions/functions.dart';
import 'package:getx_ecommerce_dashboard/routes.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final GlobalKey<FormState> formKey = GlobalKey();

  final RxBool isShowPassword = false.obs;
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    setIsLoading(true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (AppFunctions.validateAndSaveForm(formKey)) {
      final isAuthenticated = await AppRepositories.adminsRepository
          .authenticateAdmin(email, password);
      if (isAuthenticated) {
        Get.offNamed(AppRoutes.dashboard);
        print("GoTo Home");
      } else {
        AppFunctions.showErrorSnackBar();
      }
    }

    setIsLoading(false);
  }

  void setIsLoading(bool value) {
    isLoading.value = value;
  }
}
