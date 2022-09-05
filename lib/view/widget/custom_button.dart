import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.padding,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Get.theme.primaryColor,
      textColor: Colors.white,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: Get.width * .15,
            vertical: 15,
          ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }
}
