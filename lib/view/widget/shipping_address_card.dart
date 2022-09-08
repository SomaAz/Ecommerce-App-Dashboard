import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/data/model/shipping_address_model.dart';
import 'package:getx_ecommerce_dashboard/view/widget/custom_radio.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class ShippingAddressCard extends StatelessWidget {
  //
  final ShippingAddressModel address;
  final void Function(ShippingAddressModel address)? onDelete;
  final void Function(ShippingAddressModel address)? onEdit;
  const ShippingAddressCard(
    this.address, {
    this.onDelete,
    this.onEdit,
    this.haveActions = true,
    Key? key,
  })  : selectedAddress = null,
        onChanged = null,
        super(key: key);

  //---------Radio---------
  final ShippingAddressModel? selectedAddress;
  final void Function(ShippingAddressModel)? onChanged;
  const ShippingAddressCard.radio(
    this.address, {
    required this.selectedAddress,
    required this.onChanged,
    this.onDelete,
    this.onEdit,
    this.haveActions = true,
    Key? key,
  }) : super(key: key);

  final bool haveActions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              address.name,
              style: Get.textTheme.headline4,
            ),
            const GapH(6),
            Text(
              "${address.street}, ${address.city}, ${address.state}, ${address.country}",
              style: Get.textTheme.bodyText1!
                  .copyWith(color: Colors.black, height: 1.6),
              maxLines: 2,
              softWrap: true,
            ),
          ],
        ),
        const Spacer(),
        if (onChanged != null)
          CustomRadio<ShippingAddressModel>(
            value: address,
            groupValue: selectedAddress!,
            onChanged: onChanged!,
            // activeColor: Get.theme.primaryColor,
          ),
        if (haveActions)
          PopupMenuButton(
            onCanceled: () => log('popup menu button canceled'),
            onSelected: (value) {
              switch (value) {
                case "Delete":
                  onDelete?.call(address);
                  break;
                case "Edit":
                  onEdit?.call(address);
                  break;
                default:
                  return;
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: "Delete",
                child: Text("Delete"),
              ),
              PopupMenuItem(
                value: "Edit",
                child: Text("Edit"),
              ),
            ],
          ),
      ],
    );
  }
}
