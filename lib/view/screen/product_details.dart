import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/product_details_controller.dart';
import 'package:getx_ecommerce_dashboard/controller/products_controller.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: Get.height * .23,
            flexibleSpace: Hero(
              tag: "image:${controller.product.id}",
              child: Image.network(
                controller.product.image,
                fit: BoxFit.fill,
                // placeholder: (_, __) => const ShimmerWidget(),
              ),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (_) {
                  return [
                    const PopupMenuItem(
                      value: "edit",
                      child: Text("Edit Info"),
                    ),
                    const PopupMenuItem(
                      value: "delete",
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ];
                },
                onSelected: (value) {
                  switch (value) {
                    case "delete":
                      controller.deleteProduct();
                      break;
                    case "edit":
                      break;
                  }
                },
              ),
              const GapW(15),
            ],
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: "name:${controller.product.id}",
                          child: Text(
                            controller.product.name,
                            style: Get.textTheme.headline2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const GapH(5),
                      SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: "brand:${controller.product.id}",
                          child: Text(
                            controller.product.brand,
                            style: Get.textTheme.headline4,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const GapH(10),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "in: ${controller.product.categoryName..capitalizeFirst}",
                          style: Get.textTheme.headline5,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const GapH(15),
                      SizedBox(
                        width: double.infinity,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "price:  ",
                                style: Get.textTheme.headline4,
                              ),
                              TextSpan(
                                text: "\$${controller.product.price}",
                                style: Get.textTheme.headline4!.copyWith(
                                  color: Get.theme.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const GapH(15),
                      SizedBox(
                        width: double.infinity,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "status:  ",
                                style: Get.textTheme.headline4,
                              ),
                              TextSpan(
                                text: controller.product.status.name,
                                style: Get.textTheme.headline4!.copyWith(
                                  color: controller.product.status.color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const GapH(30),
                      // SizedBox(
                      //   child: Flex(
                      //     direction: Axis.horizontal,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: const [
                      //       Flexible(
                      //         child: SizeSelectChip(),
                      //       ),
                      //       GapW(20),
                      //       Flexible(
                      //         child: ColorSelectChip(),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const GapH(20),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Description",
                          style: Get.textTheme.headline3,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: "desc:${controller.product.id}",
                          child: Text(
                            controller.product.description,
                            style: Get.textTheme.bodyText1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   // color: Colors.amber,
      //   padding: const EdgeInsets.symmetric(horizontal: 15),
      //   height: Get.statusBarHeight,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
