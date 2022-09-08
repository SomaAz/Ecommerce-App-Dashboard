import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/orders_controller.dart';
import 'package:getx_ecommerce_dashboard/core/constants/theme.dart';
import 'package:getx_ecommerce_dashboard/view/widget/app_drawer.dart';
import 'package:getx_ecommerce_dashboard/view/widget/centered_text.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';
import 'package:getx_ecommerce_dashboard/view/widget/order_card.dart';
import 'package:getx_ecommerce_dashboard/view/widget/shimmers/order_card_shimmer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Orders"),
        titleTextStyle: AppTheme.appBarTitleStyle,
        actions: [
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: "filter",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.filter_list),
                      GapW(4),
                      Text("Fitler Orders"),
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
              }
            },
          ),
          // GetBuilder<OrdersController>(
          //   builder: (controller) {
          //     return DropdownButton<OrderStatus>(
          //       value: controller.ordersStatus,
          //       items: [
          //         const DropdownMenuItem(value: null, child: Text("All")),
          //         DropdownMenuItem(
          //           value: OrderStatus.processing,
          //           child: Text(
          //             OrderStatus.processing.name,
          //             style: TextStyle(color: OrderStatus.processing.color),
          //           ),
          //         ),
          //         DropdownMenuItem(
          //           value: OrderStatus.delivered,
          //           child: Text(
          //             OrderStatus.delivered.name,
          //             style: TextStyle(color: OrderStatus.delivered.color),
          //           ),
          //         ),
          //         DropdownMenuItem(
          //           value: OrderStatus.canceled,
          //           child: Text(
          //             OrderStatus.canceled.name,
          //             style: TextStyle(color: OrderStatus.canceled.color),
          //           ),
          //         ),
          //       ],
          //       onChanged: controller.setOrdersStatus,
          //       underline: const Gap(),
          //     );
          //   },
          // ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        child: ListView(
          controller: controller.scrollController,
          // title: "Orders",

          children: [
            GetBuilder<OrdersController>(
              builder: (controller) {
                if (!controller.isLoading) {
                  if (controller.orders.isEmpty) {
                    return const CenteredText("You Don't Have Any Orders");
                  }
                  if (controller.filteredOrders.isEmpty) {
                    return SizedBox(
                      height: Get.height - Get.statusBarHeight,
                      child: CenteredText(
                        "You Don't Have Any ${controller.ordersStatus?.name} Orders",
                      )..isNullOrBlank,
                    );
                  }
                }
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const GapH(20),
                  itemBuilder: (context, index) {
                    if (controller.isLoading) {
                      return const OrderCardShimmer();
                    }

                    final order = controller.filteredOrders[index];
                    return OrderCard(
                      order,
                      quantity: controller.quantityOfOrder(order),
                    );
                  },
                  itemCount: controller.isLoading
                      ? (Get.height ~/ (Get.height * .2))
                      : controller.filteredOrders.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
