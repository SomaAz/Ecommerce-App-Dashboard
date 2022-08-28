import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/enums/validated_input_type.dart';

class AppFunctions {
  //? Validate Form
  static bool validateForm(GlobalKey<FormState> formKey) {
    final formState = formKey.currentState;

    if (formState != null) {
      return formState.validate();
    }

    return false;
  }

  //? Validate Form
  static bool validateAndSaveForm(GlobalKey<FormState> formKey) {
    final isValid = validateForm(formKey);
    final formState = formKey.currentState;

    if (formState != null) {
      formKey.currentState!.save();
    }

    return isValid;
  }

  //? Validate Form
  static String? validateField(
    String? value, {
    int? min,
    int? max,
    ValidatedInputType inputType = ValidatedInputType.other,
  }) {
    if (!(value != null && value.trim().isNotEmpty)) {
      return "Please Enter A Value In This Field";
    }
    value = value.trim();

    if (min != null && value.length < min) {
      return "This Value Length Can't Be Less Than $min Characters";
    }
    if (max != null && value.length > max) {
      return "This Value Length Can't Be More Than $max Characters";
    }

    if (inputType == ValidatedInputType.email) {
      if (!GetUtils.isEmail(value)) {
        return "Please Type A Valid Email";
      }
    }
    if (inputType == ValidatedInputType.username) {
      if (!GetUtils.isUsername(value)) {
        return "Please Type A Valid Username";
      }
    }

    return null;
  }

  static void showErrorSnackBar({String text = ""}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Error",
        text,
        backgroundColor: Get.theme.errorColor,
        colorText: Colors.white,
      );
    }
  }
}
