import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/constants/colors.dart';
import 'package:getx_ecommerce_dashboard/view/widget/bottom_sheet_handle.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class FilterBottomSheetHeader extends StatelessWidget {
  const FilterBottomSheetHeader({
    required this.onClear,
    Key? key,
  }) : super(key: key);
  final void Function() onClear;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BottomSheetHandle(),
        const GapH(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Filter Products",
              style: Get.textTheme.headline3
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            TextButton(
              onPressed: onClear,
              style: TextButton.styleFrom(primary: AppColors.errorColor),
              child: const Text(
                "Clear Filters",
                // style: Get.textTheme.headline5
                //     ?.copyWith(color: ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
