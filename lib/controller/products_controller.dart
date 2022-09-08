import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/filter_bottom_sheet_controller.dart';
import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';
import 'package:getx_ecommerce_dashboard/core/functions/functions.dart';
import 'package:getx_ecommerce_dashboard/data/model/product_model.dart';
import 'package:getx_ecommerce_dashboard/view/widget/custom_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/filter_bottom_sheet_header.dart';
import 'package:getx_ecommerce_dashboard/view/widget/filter_dropdown_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';

class ProductsController extends GetxController {
  List<ProductModel> products = [];

  List<ProductModel> get filteredProducts {
    var returnedFilteredProducts = products;

    if (categoryFilter != null) {
      returnedFilteredProducts = returnedFilteredProducts
          .where((element) => element.categoryName == categoryFilter)
          .toList();
    }

    if (statusFilter != null) {
      returnedFilteredProducts = returnedFilteredProducts
          .where((element) => element.status == statusFilter)
          .toList();
    }
    return returnedFilteredProducts;
  }

  // bool get filtersApplied => categoryFilter != null || statusFilter != null;

  String? categoryFilter;
  ProductStatus? statusFilter;

  void setCategoryFilter(String? value) {
    categoryFilter = value;
    update();
  }

  void setStatusFilter(ProductStatus? value) {
    statusFilter = value;
    update();
  }

  List<String> get categories =>
      products.map((product) => product.categoryName).toSet().toList();

  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  bool isLoading = false;

  void setIsLoadMoreRunning(bool value) {
    isLoadMoreRunning = value;
    update();
  }

  void setHasNextPage(bool value) {
    hasNextPage = value;
    update();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    update();
  }

  late final ScrollController scrollController;

  bool get _isExtentAfter {
    return scrollController.position.extentAfter < 10;
  }

  Future<void> loadData() async {
    setIsLoading(true);

    final fetchedProducts =
        await AppRepositories.productsRepository.getAllProducts(limit: 6);
    products = fetchedProducts;
    setIsLoading(false);
    scrollController.jumpTo(scrollController.offset + 10);
    scrollController.jumpTo(0);
  }

  Future<void> refreshData() async {
    final refreshedProducts = await AppRepositories.productsRepository
        .getAllProducts(limit: products.length);
    products = refreshedProducts;
    hasNextPage = true;
    update();
  }

  Future<void> loadMore() async {
    if (hasNextPage && !isLoading && !isLoadMoreRunning && _isExtentAfter) {
      setIsLoadMoreRunning(true);

      final fetchedProducts =
          await AppRepositories.productsRepository.getAllProducts(
        // startAfterProductCreationDate: products.last.timeCreated,
        startAfterProductName: products.last.name,
        limit: 6,
      );
      log("$fetchedProducts", name: "load more products");
      log(products.length.toString(), name: "load more products");

      if (fetchedProducts.length < 6) {
        // if(fetchedProducts.isEmpty){}
        products.addAll(fetchedProducts);
        setHasNextPage(false);
      } else {
        products.addAll(fetchedProducts);
      }
      setIsLoadMoreRunning(false);
    }
  }

  Future<bool> deleteProduct(ProductModel deletedProduct) async {
    bool isProductDeleted = false;
    await AppFunctions.showOkCancelDialog(
      text: "Are you sure you want to delete this product ?",
      onConfirm: () {
        AppRepositories.productsRepository.deleteProduct(deletedProduct).then(
          (value) {
            products.remove(deletedProduct);
            update();
            Get.back();
            isProductDeleted = true;
          },
        );
      },
    );
    return isProductDeleted;
  }

  @override
  void onInit() async {
    loadData();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
    super.onInit();
  }

  void showFilterBottomSheet() {
    Get.bottomSheet<String>(
      GetBuilder<ProductsFilterBottomSheetController>(
          init: Get.put(ProductsFilterBottomSheetController()),
          builder: (filterBottomSheetController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  FilterBottomSheetHeader(
                    onClear: () {
                      filterBottomSheetController.setCategory(null);
                      filterBottomSheetController.setProductStatus(null);
                    },
                  ),
                  const GapH(20),
                  FilterDropDownButton<String?>(
                    value: filterBottomSheetController.category,
                    title: "Category",
                    items: const <DropdownMenuItem<String?>>[
                          DropdownMenuItem(child: Text("All Categories"))
                        ] +
                        categories
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ),
                            )
                            .toList(),
                    onChanged: filterBottomSheetController.setCategory,
                  ),
                  const GapH(20),
                  FilterDropDownButton<ProductStatus?>(
                    value: filterBottomSheetController.productStatus,
                    title: "Status",
                    items: const <DropdownMenuItem<ProductStatus?>>[
                          DropdownMenuItem(
                            child: Text("All Status"),
                          ),
                        ] +
                        ProductStatus.values
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status.name),
                              ),
                            )
                            .toList(),
                    onChanged: filterBottomSheetController.setProductStatus,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: Get.width * .5,
                    child: CustomButton(
                      text: "Apply Filter",
                      onPressed: () {
                        setCategoryFilter(
                          filterBottomSheetController.category,
                        );
                        setStatusFilter(
                          filterBottomSheetController.productStatus,
                        );
                        Get.back();
                      },
                    ),
                  ),
                  const GapH(20),
                ],
              ),
            );
          }),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    );
  }
}
