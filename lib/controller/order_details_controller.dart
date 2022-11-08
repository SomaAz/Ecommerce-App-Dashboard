import 'dart:developer';

import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/enums/order_status.dart';
import 'package:getx_ecommerce_dashboard/data/model/order_model.dart';
import 'package:getx_ecommerce_dashboard/data/repository/orders_repository.dart';

class OrderDetailsController extends GetxController {
  OrderDetailsController() : order = Get.arguments['order'];

  final OrderModel order;

  Future<void> changeOrderStatus(OrderStatus newStatus) async {
    if (order.status == newStatus) return;
    try {
      order.status = newStatus;
      update();
      await OrdersRepository.instance.changeOrderStatus(order.id, newStatus);
    } catch (e) {
      log(e.toString(), name: "Change Order Status");
    }
  }
}
