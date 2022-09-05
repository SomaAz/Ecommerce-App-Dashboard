import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/constants/colors.dart';
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

  static Future<void> showOkCancelDialog({
    required String text,
    String title = "Alert",
    required void Function() onConfirm,
    void Function()? onCancel,
    String confirmText = "Ok",
    double? fontSize,
  }) async {
    await Get.defaultDialog(
      title: title,
      titleStyle:
          Get.textTheme.headline3?.copyWith(fontWeight: FontWeight.w500),
      middleText: text,
      middleTextStyle: TextStyle(fontSize: fontSize),
      onConfirm: onConfirm,
      onCancel: onCancel,
      confirmTextColor: Colors.black,
      buttonColor: Get.theme.primaryColor,
      cancelTextColor: Colors.black,
      cancel: TextButton(
        onPressed: onCancel ?? Get.back,
        style: TextButton.styleFrom(primary: AppColors.errorColor),
        child: const Text("Cancel"),
      ),
      confirm: TextButton(
        onPressed: onConfirm,
        child: Text(confirmText),
      ),
      textCancel: "cancel",
    );
  }

  static Future<void> showChoiceDialog(
      {required String text,
      String title = "Choose",
      required List<Widget>? actions
      //  void Function() onConfirm,
      // void Function()? onCancel,
      // String confirmText = "Ok",
      }) async {
    await Get.defaultDialog(
      title: title,
      titleStyle:
          Get.textTheme.headline3?.copyWith(fontWeight: FontWeight.w500),
      middleText: text,

      actions: actions,
      // onConfirm: onConfirm,
      // onCancel: onCancel,
      confirmTextColor: Colors.black,
      buttonColor: Get.theme.primaryColor,
      // cancelTextColor: Colors.black,
      // cancel: TextButton(
      //   onPressed: onCancel ?? Get.back,
      //   style: TextButton.styleFrom(primary: AppColors.errorColor),
      //   child: const Text("Cancel"),
      // ),
      // confirm: TextButton(
      //   onPressed: onConfirm,
      //   child: Text(confirmText),
      // ),
      // textCancel: "cancel",
    );
  }
}
