import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CenteredText extends StatelessWidget {
  const CenteredText(
    this.text, {
    Key? key,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Get.textTheme.headline5,
      ),
    );
  }
}
