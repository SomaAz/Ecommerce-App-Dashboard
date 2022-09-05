import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';
import 'package:getx_ecommerce_dashboard/view/widget/shimmers/shimmer_widget.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .45,
      child: Flex(
        direction: Axis.vertical,
        children: [
          const Flexible(
            flex: 2,
            child: ShimmerWidget(borderRadius: 5),
          ),
          const GapH(12),
          // const GapH(12),
          Flexible(
            child: Column(
              children: const [
                Expanded(child: ShimmerWidget()),
                GapH(12),
                Expanded(child: ShimmerWidget()),
                GapH(12),
                Expanded(child: ShimmerWidget()),
                GapH(12),
                GapH(12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
