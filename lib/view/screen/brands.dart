import 'package:flutter/material.dart';
import 'package:getx_ecommerce_dashboard/core/constants/theme.dart';
import 'package:getx_ecommerce_dashboard/view/widget/app_drawer.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brands"),
        titleTextStyle: AppTheme.appBarTitleStyle,
      ),
      drawer: const AppDrawer(),
    );
  }
}
