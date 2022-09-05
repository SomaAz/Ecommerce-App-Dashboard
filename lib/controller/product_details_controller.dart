import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/products_controller.dart';
import 'package:getx_ecommerce_dashboard/data/model/product_model.dart';

class ProductDetailsController extends GetxController {
  final ProductModel product;

  ProductDetailsController() : product = Get.arguments['product'];

  Future<void> deleteProduct() async {
    Get.find<ProductsController>().deleteProduct(product).then(
      (isProductDeleted) {
        if (isProductDeleted) Get.back();
      },
    );
  }
}
