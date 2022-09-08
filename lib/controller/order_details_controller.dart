import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/data/model/order_model.dart';

class OrderDetailsController extends GetxController {
  OrderDetailsController() : order = Get.arguments['order'];

  final OrderModel order;
}
