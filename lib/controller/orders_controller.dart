import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/filter_bottom_sheet_controller.dart';
import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/core/enums/order_status.dart';
import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';
import 'package:getx_ecommerce_dashboard/data/model/order_model.dart';
import 'package:getx_ecommerce_dashboard/view/widget/custom_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/filter_bottom_sheet_header.dart';
import 'package:getx_ecommerce_dashboard/view/widget/filter_dropdown_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class OrdersController extends GetxController {
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  bool isLoading = false;

  void setIsLoadMoreRunning(bool value) {
    isLoadMoreRunning = value;
    update();
  }

  void setHasNextPage(bool value) {
    hasNextPage = value;
    update();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    update();
  }

  late final ScrollController scrollController;

  bool get _isExtentAfter => scrollController.position.extentAfter < 20;

  List<OrderModel> orders = [];

  int quantityOfOrder(OrderModel order) {
    return order.products
        .map((product) => product.quantity)
        .reduce((a, b) => a + b);
  }

  Future<void> loadData() async {
    setIsLoading(true);
    orders = await AppRepositories.ordersRepository.getAllOrders(limit: 6);
    setIsLoading(false);
    // scrollController.jumpTo(scrollController.offset + Get.height * .2);
    // scrollController.jumpTo(0);
  }

  Future<void> refreshData() async {
    orders = await AppRepositories.ordersRepository
        .getAllOrders(limit: orders.length);
    setHasNextPage(true);
  }

  void setOrder(OrderModel newOrder) {
    final refreshedOrderIndex = orders.indexWhere((e) => e.id == newOrder.id);

    orders[refreshedOrderIndex] = newOrder;

    update();
  }

  Future<void> loadMore() async {
    if (hasNextPage && !isLoading && !isLoadMoreRunning && _isExtentAfter) {
      setIsLoadMoreRunning(true);

      final fetchedOrders = await AppRepositories.ordersRepository.getAllOrders(
        startAfterOrderTimeOrdered: orders.last.timeOrdered,
        limit: 6,
      );

      if (fetchedOrders.isNotEmpty) {
        orders.addAll(fetchedOrders);
        log("Loaded Other ${fetchedOrders.length} Orders");
      } else {
        setHasNextPage(false);
      }
      setIsLoadMoreRunning(false);
    }
  }

  OrderStatus? ordersStatus;

  void setOrdersStatus(OrderStatus? status) {
    ordersStatus = status;
    update();
  }

  List<OrderModel> get filteredOrders {
    if (ordersStatus == null) return orders;
    return orders.where((order) => order.status == ordersStatus).toList();
  }

  void showFilterBottomSheet() {
    Get.bottomSheet<String>(
      GetBuilder<OrdersFilterBottomSheetController>(
          init: Get.put(OrdersFilterBottomSheetController()),
          builder: (filterBottomSheetController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  FilterBottomSheetHeader(
                    onClear: () {
                      filterBottomSheetController.setOrderStatus(null);
                    },
                  ),
                  const GapH(20),
                  FilterDropDownButton<OrderStatus?>(
                    value: filterBottomSheetController.orderStatus,
                    title: "Order Status",
                    items: const <DropdownMenuItem<OrderStatus?>>[
                          DropdownMenuItem(child: Text("All Status"))
                        ] +
                        OrderStatus.values
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(
                                  status.name,
                                  style: TextStyle(color: status.color),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: filterBottomSheetController.setOrderStatus,
                  ),
                  const GapH(20),
                  const Spacer(),
                  SizedBox(
                    width: Get.width * .5,
                    child: CustomButton(
                      text: "Apply Filter",
                      onPressed: () {
                        setOrdersStatus(
                          filterBottomSheetController.orderStatus,
                        );

                        Get.back();
                      },
                    ),
                  ),
                  const GapH(20),
                ],
              ),
            );
          }),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    );
  }

  @override
  void onInit() {
    loadData();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
    super.onInit();
  }
}
