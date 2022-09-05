import 'package:get/get.dart';

import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';

class FilterBottomSheetController extends GetxController {
  String? category;
  ProductStatus? productStatus;

  FilterBottomSheetController({
    this.category,
    this.productStatus,
  });

  void setCategory(String? newCategory) {
    category = newCategory;
    update();
    print(category);
  }

  void setProductStatus(ProductStatus? newProductStatus) {
    productStatus = newProductStatus;
    update();
    print(productStatus);
  }
}
