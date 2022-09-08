import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/filter_bottom_sheet_controller.dart';
import 'package:getx_ecommerce_dashboard/controller/products_controller.dart';
import 'package:getx_ecommerce_dashboard/core/constants/colors.dart';
import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';
import 'package:getx_ecommerce_dashboard/core/enums/validated_input_type.dart';
import 'package:getx_ecommerce_dashboard/view/widget/bottom_sheet_handle.dart';
import 'package:getx_ecommerce_dashboard/view/widget/custom_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/filter_dropdown_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

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

  // static Future showFilterBottomSheet({
  //   required List<FilterDropDownButton> dropDownButtons,
  //   required String title,
  //   required void Function() onApplyFilters,
  // }) async {
  //   await Get.bottomSheet<String>(
  //     GetBuilder<FilterBottomSheetController>(
  //         init: Get.put(
  //           FilterBottomSheetController(
  //             dropDownButtons
  //                 .map((e) => e.items?.map((e) => e.value).toList())
  //                 .toList(),
  //           ),
  //         ),
  //         builder: (filterBottomSheetController) {
  //           List<FilterDropDownButton> buttons = [];
  //           for (var i = 0; i < dropDownButtons.length; i++) {
  //             buttons[i] = dropDownButtons[i].copyWith(
  //               onChanged: (newValue) {
  //                 print(newValue);
  //                 filterBottomSheetController.setValue(
  //                   i,
  //                   newValue,
  //                 );
  //               },
  //             );
  //           }

  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //             child: Column(
  //               children: [
  //                 const BottomSheetHandle(),
  //                 const GapH(10),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       title,
  //                       style: Get.textTheme.headline3
  //                           ?.copyWith(fontWeight: FontWeight.w500),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         // filterBottomSheetController.setCategory(null);
  //                         // filterBottomSheetController.setProductStatus(null);
  //                       },
  //                       style:
  //                           TextButton.styleFrom(primary: AppColors.errorColor),
  //                       child: const Text(
  //                         "Clear Filters",
  //                         // style: Get.textTheme.headline5
  //                         //     ?.copyWith(color: ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 ...buttons,
  //                 const Spacer(),
  //                 SizedBox(
  //                   width: Get.width * .5,
  //                   child: CustomButton(
  //                     text: "Apply Filters",
  //                     onPressed: onApplyFilters,
  //                     padding: const EdgeInsets.symmetric(
  //                       vertical: 10,
  //                       horizontal: 10,
  //                     ),
  //                   ),
  //                 ),
  //                 const GapH(20),
  //               ],
  //             ),
  //           );
  //         }),
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(30),
  //       ),
  //     ),
  //   );
  // }

  static void showPopupMenu({
    required BuildContext context,
    required GlobalKey widgetKey,
    required Function(dynamic value) onSelected,
  }) async {
    final RenderBox renderBox =
        widgetKey.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    // print('Offset: ${offset.dx}, ${offset.dy}');

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: const [
        PopupMenuItem(
          value: "Delete",
          child: Text("Delete"),
        ),
        PopupMenuItem(
          value: "Edit",
          child: Text("Edit"),
        ),
      ],
    ).then(onSelected);
  }

  static String splitCardNumber(String cardNumber) {
    final newCardNumber = cardNumber.trim().replaceAll(" ", "");
    String newStr = '';
    const step = 4;

    for (var i = 0; i < newCardNumber.length; i += step) {
      newStr +=
          newCardNumber.substring(i, math.min(i + step, newCardNumber.length));
      if (i + step < newCardNumber.length) newStr += ' ';
    }

    return newStr;
  }

  static String splitAndHideCardNumber(String cardNumber) {
    final newCardNumber = cardNumber.trim().replaceAll(" ", "");
    String newStr = '';
    const step = 4;

    for (var i = 0; i < newCardNumber.length; i += step) {
      if (i < newCardNumber.length - step) {
        newStr += "X" *
            newCardNumber
                .substring(
                  i,
                  math.min(i + step, newCardNumber.length),
                )
                .length;
        if (i + step < newCardNumber.length) newStr += ' ';
      } else {
        newStr += newCardNumber.substring(
            i, math.min(i + step, newCardNumber.length));
      }
    }

    return newStr;
  }
}
