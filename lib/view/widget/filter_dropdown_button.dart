import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class FilterDropDownButton<T> extends StatelessWidget {
  const FilterDropDownButton({
    Key? key,
    required this.value,
    required this.text,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  final String text;
  final T value;
  final List<DropdownMenuItem<T?>>? items;
  final void Function(T?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "$text:   ",
            style: Get.textTheme.headline5,
          ),
        ),
        Flexible(
          child: SizedBox(
            child: InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
              child: DropdownButton<T?>(
                value: value,
                underline: const Gap(),
                items: items,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
