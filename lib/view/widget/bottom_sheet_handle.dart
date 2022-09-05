import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7,
      width: Get.width * .25,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
