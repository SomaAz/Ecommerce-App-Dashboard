import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/products_controller.dart';
import 'package:getx_ecommerce_dashboard/core/constants/theme.dart';
import 'package:getx_ecommerce_dashboard/routes.dart';
import 'package:getx_ecommerce_dashboard/view/widget/app_drawer.dart';
import 'package:getx_ecommerce_dashboard/view/widget/centered_text.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';
import 'package:getx_ecommerce_dashboard/view/widget/product_card.dart';
import 'package:getx_ecommerce_dashboard/view/widget/shimmers/cart_product_shimmer.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        // titleTextStyle: AppTheme.appBarTitleStyle,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.filter_list),
          //   onPressed: controller.showFilterBottomSheet,
          // ),
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: "add",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.add),
                      GapW(4),
                      Text("Add product"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "filter",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.filter_list),
                      GapW(4),
                      Text("Fitler Products"),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case "filter":
                  controller.showFilterBottomSheet();
                  break;
                case "add":
                  Get.toNamed(AppRoutes.newProduct);
                  break;
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          if (!controller.isLoading) {
            await controller.refreshData();
          }
        },
        child: GetBuilder<ProductsController>(
          builder: (controller) {
            if (!controller.isLoading) {
              if (controller.products.isEmpty) {
                return const CenteredText("There are no products");
              } else if (controller.filteredProducts.isEmpty) {
                return const CenteredText(
                  "There are no products matches your filters",
                );
              }
            }

            return ListView.separated(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              itemCount:
                  controller.isLoading ? 5 : controller.filteredProducts.length,
              separatorBuilder: (_, __) => const GapH(15),
              itemBuilder: (_, index) {
                if (controller.isLoading) {
                  return const ProductShimmer();
                }
                return ProductCard(
                  controller.filteredProducts[index],
                  onDelete: () => controller
                      .deleteProduct(controller.filteredProducts[index]),
                  onEdit: () => Get.toNamed(
                    AppRoutes.editProduct,
                    arguments: {"product": controller.filteredProducts[index]},
                  ),
                  onView: () => Get.toNamed(
                    AppRoutes.productDetails,
                    arguments: {"product": controller.filteredProducts[index]},
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
