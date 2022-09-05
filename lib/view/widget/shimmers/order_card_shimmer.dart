import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/view/widget/shimmers/shimmer_widget.dart';

class OrderCardShimmer extends StatelessWidget {
  const OrderCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      height: Get.height * .2,
      width: double.infinity,
      borderRadius: 6,
    );
  }
}
