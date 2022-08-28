import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/constants/colors.dart';
import 'package:getx_ecommerce_dashboard/routes.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            child: Center(
              child: Text(
                "Control Panel\n",
                style: Get.textTheme.headline2?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.offAllNamed(AppRoutes.dashboard);
            },
            leading: const Icon(Icons.home),
            title: Text("Dashboard", style: Get.textTheme.headline5),
          ),
          const GapH(6),
          ListTile(
            onTap: () {
              Get.offAllNamed(AppRoutes.products);
            },
            leading: const Icon(Icons.shopping_bag_rounded),
            title: Text("Products", style: Get.textTheme.headline5),
          ),
          const GapH(6),
          ListTile(
            onTap: () {
              Get.offAllNamed(AppRoutes.orders);
            },
            leading: const Icon(Icons.shopping_cart_rounded),
            title: Text("Orders", style: Get.textTheme.headline5),
          ),
          const GapH(6),
          ListTile(
            onTap: () {
              Get.offAllNamed(AppRoutes.brands);
            },
            leading: const Icon(Icons.stars_rounded),
            title: Text("Brands", style: Get.textTheme.headline5),
          ),
          const GapH(6),
          ListTile(
            onTap: () {
              Get.offAllNamed(AppRoutes.statistics);
            },
            leading: const Icon(Icons.analytics_rounded),
            title: Text("Statistics", style: Get.textTheme.headline5),
          ),
        ],
      ),
    );
  }
}
