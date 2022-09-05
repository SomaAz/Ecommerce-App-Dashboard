import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/data/model/product_model.dart';
import 'package:getx_ecommerce_dashboard/routes.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
    this.product, {
    this.onDelete,
    Key? key,
  }) : super(key: key);

  final ProductModel product;
  final void Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.productDetails, arguments: {"product": product});
      },
      child: SizedBox(
        height: Get.height * .17,
        child: Flex(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          direction: Axis.horizontal,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  product.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const GapW(10),
            Flexible(
              fit: FlexFit.tight,
              flex: 35,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Get.textTheme.headline4,
                        ),
                        const GapH(2),
                        // Text(
                        //   "\$${product.price}",
                        //   style: Get.textTheme.headline4!
                        //       .copyWith(color: Get.theme.primaryColor),
                        // ),
                        Text(
                          "${product.categoryName.capitalizeFirst}",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.circular(15),
                            color: product.status.color.withOpacity(.15),
                          ),
                          child: Text(
                            product.status.name,
                            style: Get.textTheme.headline5?.copyWith(
                              color: product.status.color,
                            ),
                          ),
                        ),
                        Text(
                          "\$${product.price}",
                          style: Get.textTheme.headline4!
                              .copyWith(color: Get.theme.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: PopupMenuButton(
                itemBuilder: (_) {
                  return [
                    const PopupMenuItem(
                      value: "view",
                      child: Text("View Details"),
                    ),
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
                      onDelete?.call();
                      break;
                    case "view":
                      Get.toNamed(
                        AppRoutes.productDetails,
                        arguments: {"product": product},
                      );
                      break;
                    case "edit":
                      Get.toNamed(
                        AppRoutes.editProduct,
                        arguments: {"product": product},
                      );
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
