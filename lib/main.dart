import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/constants/theme.dart';
import 'package:getx_ecommerce_dashboard/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const EcommerceGetxDashboardApp());
}

class EcommerceGetxDashboardApp extends StatelessWidget {
  const EcommerceGetxDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Ecommerce Dashboard',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.dashboard,
      getPages: AppRoutes.getPages,
      debugShowCheckedModeBanner: false,
    );
  }
}


//todos:
//TODO: Ad try catch for the two apps(Customer & Dashboard) in all queries and async await

//TODO: Daily Tasks:
//! Failed In It: TODO: make  filter bottom sheet works dynamically
//TODO: make (orders filter bottom sheet)
//TODO: make (order details view)
//TODO: make (change status) feature in order details view
//TODO: make (change tracking status) feature in order details view
