import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/constants/theme.dart';
import 'package:getx_ecommerce_dashboard/view/widget/app_drawer.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        titleTextStyle: AppTheme.appBarTitleStyle,
      ),
      drawer: const AppDrawer(),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: 12,
        separatorBuilder: (_, __) => const GapH(15),
        itemBuilder: (_, index) {
          return SizedBox(
            height: Get.height * .17,
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              direction: Axis.horizontal,
              children: [
                const Flexible(
                  fit: FlexFit.tight,
                  flex: 20,
                  child: FlutterLogo(),
                ),
                const GapW(10),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 35,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nike Boot",
                          style: Get.textTheme.headline4,
                        ),
                        const GapH(10),
                        Text(
                          "\$100",
                          style: Get.textTheme.headline4!
                              .copyWith(color: Get.theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopupMenuButton(
                    itemBuilder: (_) {
                      return [
                        const PopupMenuItem(
                          child: Text("View Details"),
                        ),
                        const PopupMenuItem(
                          child: Text("Edit Info"),
                        ),
                        const PopupMenuItem(
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
