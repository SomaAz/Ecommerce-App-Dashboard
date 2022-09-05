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
      height: Get.height * .17,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          const Flexible(flex: 20, child: ShimmerWidget()),
          const GapW(20),
          Flexible(
            flex: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: const [
                      ShimmerWidget(
                        width: double.infinity,
                        height: 15,
                      ),
                      GapH(8),
                      ShimmerWidget(
                        width: double.infinity,
                        height: 15,
                      ),
                    ],
                  ),
                  const ShimmerWidget(
                    width: double.infinity,
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
