import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/order_details_controller.dart';
import 'package:getx_ecommerce_dashboard/core/enums/delivery_type.dart';
import 'package:getx_ecommerce_dashboard/core/enums/order_status.dart';
import 'package:getx_ecommerce_dashboard/view/widget/custom_credit_card.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';
import 'package:getx_ecommerce_dashboard/view/widget/order_product_card.dart';
import 'package:getx_ecommerce_dashboard/view/widget/shipping_address_card.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: GetBuilder<OrderDetailsController>(
        builder: (controller) {
          final order = controller.order;
          return ListView(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No.${order.number}",
                    style: Get.textTheme.headline4,
                  ),
                  Text(
                    DateFormat("dd-MM-yyyy").format(
                      order.timeOrdered.toDate(),
                    ),
                    style: Get.textTheme.bodyText1!.copyWith(height: 0),
                  ),
                ],
              ),
              const GapH(10),
              Text(
                order.status.name,
                style: Get.textTheme.headline5!
                    .copyWith(color: order.status.color),
              ),
              const GapH(40),
              Text(
                "${order.products.length} items",
                style: Get.textTheme.headline4,
              ),
              const GapH(10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const GapH(15),
                itemBuilder: ((context, index) {
                  return OrderProductCard(order.products[index]);
                }),
                itemCount: order.products.length,
              ),
              const GapH(40),
              Text(
                "Order Information",
                style: Get.textTheme.headline3
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const GapH(25),
              Text(
                "Shipping Address",
                style: Get.textTheme.headline4!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const GapH(15),
              SizedBox(
                width: double.infinity,
                child: ShippingAddressCard(
                  order.shippingAddress,
                  haveActions: false,
                ),
              ),
              const GapH(30),
              Text(
                "Payment Card",
                style: Get.textTheme.headline4!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const GapH(15),
              CustomCreditCard(
                order.paymentCard.copyWith(
                  number: order.paymentCard.number.replaceRange(
                    0,
                    order.paymentCard.number.length - 4,
                    "*" * (order.paymentCard.number.length - 7),
                  ),
                ),
                haveActions: false,
              ),
              const GapH(25),
              Row(
                children: [
                  Text(
                    "Delivery Method:  ",
                    style: Get.textTheme.headline4!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  // Text(
                  //   "Delivery Method:  ",
                  //   style: Get.textTheme.bodyText1!.copyWith(height: 0),
                  // ),
                  Text(
                    "${order.deliveryType == DeliveryType.standard ? "Standard" : "Next Day"} Delivery",
                    style: Get.textTheme.headline5!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const GapH(20),
              Text(
                "Payment Details:  ",
                style: Get.textTheme.headline4!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const GapH(10),
              Row(
                children: [
                  Text(
                    "Subtotal:  ",
                    style: Get.textTheme.headline5,
                  ),
                  Text(
                    "\$${order.price - order.deliveryType.price}",
                    style: Get.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                ],
              ),
              const GapH(8),
              Row(
                children: [
                  Text(
                    "Delivery Cost:  ",
                    style: Get.textTheme.headline5,
                  ),
                  Text(
                    "\$${order.deliveryType.price}",
                    style: Get.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                ],
              ),
              const GapH(8),
              Row(
                children: [
                  Text(
                    "Total Price:  ",
                    style: Get.textTheme.headline5
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "\$${order.price}",
                    style: Get.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: GetBuilder<OrderDetailsController>(
        builder: (controller) {
          return Container(
            height: Get.statusBarHeight,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Change Status: ",
                  style: Get.textTheme.headline4,
                ),
                // DropdownButton<OrderStatus>(items: [], onChanged: (value) {}),
              ],
            ),
          );
        },
      ),
    );
  }
}
