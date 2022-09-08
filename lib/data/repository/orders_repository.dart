import 'dart:developer';

import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/core/enums/order_status.dart';
import 'package:getx_ecommerce_dashboard/data/model/order_model.dart';

abstract class OrdersRepositoryBase {
  Future<List<OrderModel>> getAllOrders();
  Future<int> getOrderNumber();
  Future<OrderModel> getOrderOfId(String id);
  Future<void> changeOrderStatus(OrderModel order, OrderStatus newStatus);
}

class OrdersRepository extends OrdersRepositoryBase {
  static final OrdersRepository instance = OrdersRepository._();
  OrdersRepository._();

  final _ordersCollection = firestore.collection("orders");

  @override
  Future<List<OrderModel>> getAllOrders({
    dynamic startAfterOrderTimeOrdered,
    int? limit,
  }) async {
    var query = _ordersCollection.orderBy("timeOrdered", descending: true);
    if (limit != null) {
      query = query.limit(limit);
    }

    if (startAfterOrderTimeOrdered != null) {
      query = query.startAfter([startAfterOrderTimeOrdered]);
    }

    final snapshot = await query.get();
    final docs = snapshot.docs;
    final orders = docs.map((doc) => OrderModel.fromMap(doc.data())).toList();

    return orders;
  }

  @override
  Future<int> getOrderNumber() async {
    final snapshot = await _ordersCollection
        .orderBy("number", descending: true)
        .limit(1)
        .get();
    log(snapshot.docs.toString());
    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;

      final orderModel = OrderModel.fromMap(doc.data());

      final prevOrderNumber = orderModel.number;
      final currentOrderNumber = prevOrderNumber + 1;

      return currentOrderNumber;
    }

    return 1;
  }

  @override
  Future<OrderModel> getOrderOfId(String id) async {
    final docRef = _ordersCollection.doc(id);

    final snapshot = await docRef.get();

    if (snapshot.data() != null) {
      return OrderModel.fromMap(snapshot.data()!);
    }

    throw "No Order Of ID:$id";
  }

  @override
  Future<void> changeOrderStatus(
    OrderModel order,
    OrderStatus newStatus,
  ) async {
    final docRef = _ordersCollection.doc(order.id);

    await docRef.update({"status": newStatus.name});
  }
}
