import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/enums/order_status.dart';

import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';

// abstract class FilterBottomSheetController extends GetxController {
//   void applyFilters();
//   void clearFilters();
// }
// class FilterBottomSheetController extends GetxController {
//   void applyFilters() {}
//   void clearFilters() {}
//   void setValue(int index, newValue) {
//     print(values[index]);
//     values[index] = newValue;
//     update();
//   }

//   final List values;

//   FilterBottomSheetController(this.values);
// }

class ProductsFilterBottomSheetController extends GetxController {
  String? category;
  ProductStatus? productStatus;

  ProductsFilterBottomSheetController({
    this.category,
    this.productStatus,
  });

  void setCategory(String? newCategory) {
    category = newCategory;
    update();
    // print(category);
  }

  void setProductStatus(ProductStatus? newProductStatus) {
    productStatus = newProductStatus;
    update();
  }
}

class OrdersFilterBottomSheetController extends GetxController {
  OrderStatus? orderStatus;

  OrdersFilterBottomSheetController({
    this.orderStatus,
  });

  void setOrderStatus(OrderStatus? newOrderStatus) {
    orderStatus = newOrderStatus;
    update();
  }
}
