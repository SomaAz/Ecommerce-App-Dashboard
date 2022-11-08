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
          const NavigationListTile(
            AppRoutes.dashboard,
            title: "Dashboard",
            icon: Icons.home,
          ),
          const GapH(6),
          const NavigationListTile(
            AppRoutes.products,
            title: "Products",
            icon: Icons.shopping_bag_rounded,
          ),
          const GapH(6),
          const NavigationListTile(
            AppRoutes.orders,
            title: "Orders",
            icon: Icons.shopping_cart_rounded,
          ),
          // const GapH(6),
          // const NavigationListTile(
          //   AppRoutes.brands,
          //   title: "Brands",
          //   icon: Icons.stars_rounded,
          // ),
          // const GapH(6),
          // const NavigationListTile(
          //   AppRoutes.statistics,
          //   title: "Statistics",
          //   icon: Icons.analytics_rounded,
          // ),
        ],
      ),
    );
  }
}

class NavigationListTile extends StatelessWidget {
  const NavigationListTile(
    this.route, {
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String route;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (Get.currentRoute != route) {
          Get.offAllNamed(route);
        } else {
          Get.back();
        }
      },
      leading: Icon(icon),
      title: Text(title, style: Get.textTheme.headline5),
    );
  }
}
