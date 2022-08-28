import 'package:flutter/material.dart';
import 'package:getx_ecommerce_dashboard/core/constants/theme.dart';
import 'package:getx_ecommerce_dashboard/view/widget/app_drawer.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistics"),
        titleTextStyle: AppTheme.appBarTitleStyle,
      ),
      drawer: const AppDrawer(),
    );
  }
}
