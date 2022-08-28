import 'package:flutter/material.dart';
import 'package:getx_ecommerce_dashboard/core/constants/theme.dart';
import 'package:getx_ecommerce_dashboard/view/widget/app_drawer.dart';
import 'package:getx_ecommerce_dashboard/view/widget/dashboard/info_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        titleTextStyle: AppTheme.appBarTitleStyle,
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: const [
          InfoCard(
            title: "Total Sales",
            value: "\$19,304,200.23",
            icon: Icons.attach_money_outlined,
            color: Colors.blue,
          ),
          InfoCard(
            title: "Total Orders",
            value: "5633",
            icon: Icons.local_shipping_outlined,
          ),
          InfoCard(
            title: "Total Products",
            value: "3004",
            icon: Icons.shopping_basket_outlined,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}
