import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/login_controller.dart';
import 'package:getx_ecommerce_dashboard/view/screen/Orders.dart';
import 'package:getx_ecommerce_dashboard/view/screen/brands.dart';
import 'package:getx_ecommerce_dashboard/view/screen/dashboard.dart';
import 'package:getx_ecommerce_dashboard/view/screen/login.dart';
import 'package:getx_ecommerce_dashboard/view/screen/products.dart';
import 'package:getx_ecommerce_dashboard/view/screen/statistics.dart';

class AppRoutes {
  AppRoutes._();

  static const dashboard = "/dashboard";
  static const login = "/login";
  static const products = "/products";
  static const orders = "/orders";
  static const brands = "/brands";
  static const statistics = "/statistics";

  static final List<GetPage> getPages = [
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
      // binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: products,
      page: () => const ProductsScreen(),
      // binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: orders,
      page: () => const OrdersScreen(),
      // binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: brands,
      page: () => const BrandsScreen(),
      // binding: BindingsBuilder.put(() => LoginController()),
    ),
    GetPage(
      name: statistics,
      page: () => const StatisticsScreen(),
      // binding: BindingsBuilder.put(() => LoginController()),
    ),
  ];
}
