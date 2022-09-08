import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/data/model/order_model.dart';
import 'package:getx_ecommerce_dashboard/routes.dart';
import 'package:getx_ecommerce_dashboard/view/widget/custom_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
    this.order, {
    required this.quantity,
    Key? key,
  }) : super(key: key);

  final OrderModel order;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .2,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$quantity ",
                          style: Get.textTheme.headline4,
                        ),
                        TextSpan(
                          text: "items",
                          style: Get.textTheme.bodyText1!.copyWith(height: 0),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          // text: "Total Price:  ",
                          style: Get.textTheme.bodyText1!.copyWith(height: 0),
                        ),
                        TextSpan(
                          text: "\$${order.price}",
                          style: Get.textTheme.headline4!.copyWith(
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const GapH(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      order.status.name,
                      style: Get.textTheme.headline5!.copyWith(
                        color: order.status.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  CustomButton(
                    text: "Details",
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.orderDetails,
                        arguments: {"order": order},
                      );
                    },
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
