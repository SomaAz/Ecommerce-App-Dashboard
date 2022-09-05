import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/products_controller.dart';
import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';
import 'package:getx_ecommerce_dashboard/core/functions/functions.dart';
import 'package:getx_ecommerce_dashboard/data/model/categoy_model.dart';
import 'package:getx_ecommerce_dashboard/data/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class EditProductController extends GetxController {
  final ProductModel product;
  EditProductController() : product = Get.arguments['product'];

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  File? image;

  Future<void> pickImage() async {
    await AppFunctions.showChoiceDialog(
      title: "Image source",
      text: "Choose image source",
      actions: [
        TextButton(
          onPressed: () async {
            final xfile = await ImagePicker()
                .pickImage(source: ImageSource.camera, imageQuality: 90);

            if (xfile != null) {
              image = File(xfile.path);
              Get.back();
              update();
            }
          },
          child: const Text("Camera"),
        ),
        TextButton(
          onPressed: () async {
            final xfile = await ImagePicker()
                .pickImage(source: ImageSource.gallery, imageQuality: 90);

            if (xfile != null) {
              image = File(xfile.path);
              Get.back();
              update();
            }
          },
          child: const Text("Gallery"),
        ),
      ],
    );

    if (image != null) {
      final imageSize = (await image?.length())! / 1024 / 1024;
      log("Product Image Size: ${imageSize.toStringAsFixed(3)} MB");
    }
  }

  bool isActive = true;

  void setIsActive(bool value) {
    isActive = value;
    update();
  }

  final GlobalKey<FormState> tagsFormKey = GlobalKey();
  final tagsController = TextEditingController();
  List<String> tags = [];

  void addTag() {
    if (tags.length < 5) {
      if (tagsFormKey.currentState != null) {
        if (tagsFormKey.currentState!.validate()) {
          tags.add(tagsController.text);
          log("${product.tags}");
          tagsController.clear();
          update();
        }
      }
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
    update();
  }

  CategoryModel? category;

  void setCategory(CategoryModel category) {
    this.category = category;
    update();
  }

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    update();
  }

  List<CategoryModel> categories = [];

  Future<void> loadData() async {
    setIsLoading(true);
    final fetchedCategories =
        await AppRepositories.categoriesRepository.getAllCategories();

    categories = fetchedCategories;
    if (categories.isNotEmpty) {
      category =
          categories.firstWhere((element) => element.id == product.category);
    }
    setIsLoading(false);
  }

  bool isAddingProductLoading = false;
  void setIsEditingProductLoading(bool value) {
    isAddingProductLoading = value;
    update();
  }

  Future<void> editProduct() async {
    // if (image == null) {
    //   AppFunctions.showErrorSnackBar(
    //     text: "You should add an image for the product",
    //   );
    // }
    if (formKey.currentState!.validate() && category != null) {
      final editedProduct = ProductModel(
        id: product.id,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        category: category?.id ?? product.category,
        categoryName: category?.name ?? product.categoryName,
        image: product.image,
        brand: product.brand,
        sizes: product.sizes,
        favorites: product.favorites,
        tags: tags,
        colors: product.colors,
        price: double.parse(priceController.text.trim()),
        status: isActive ? ProductStatus.active : ProductStatus.disabled,
        timeCreated: product.timeCreated,
      );
      log("${editedProduct.tags}${product.tags}");
      try {
        if (product == editedProduct) {
          if (!Get.isSnackbarOpen) {
            Get.snackbar(
              "Alert",
              "You haven't made any edits for the products",
            );
          }
        } else {
          await AppFunctions.showOkCancelDialog(
            onConfirm: () async {
              setIsEditingProductLoading(true);

              // Get.back();

              await AppRepositories.productsRepository
                  .editProduct(editedProduct, image);
            },
            text:
                """Product fields changed:\n${fieldsDifference(editedProduct)}""",
          );

          // await Get.find<ProductsController>().refreshData();
        }

        // Get.find<ProductsController>().setHasNextPage(true);
      } catch (e) {
        AppFunctions.showErrorSnackBar(text: "$e");
      } finally {
        setIsEditingProductLoading(false);
      }
    }
  }

  String? fieldDifference(valueName, firstValue, secondValue) {
    return firstValue == secondValue
        ? null
        : "$valueName: $firstValue -> $secondValue";
  }

  String fieldsDifference(ProductModel editedProduct) {
    log("${editedProduct.description.toString().substring(0, 20)}\n${product.description.toString().substring(0, 20)} ");
    final productMap = product.toMap();
    final editedProductMap = editedProduct.toMap();
    final keys = productMap.keys;

    if (productMap['description'].length > 20) {
      productMap['description'] =
          productMap['description'].toString().substring(0, 20);
    }

    if (editedProductMap['description'].length > 20) {
      editedProductMap['description'] =
          editedProductMap['description'].toString().substring(0, 20);
    }
    // final values = product.toMap().values;
    List<String> differences = [];

    for (var key in keys) {
      log(key);
      final difference =
          fieldDifference(key, productMap[key], editedProductMap[key]);
      if (difference != null) {
        differences.add(difference);
      }
    }

    return differences.join("\n");
  }

  @override
  void onInit() {
    loadData();
    nameController.text = product.name;
    descriptionController.text = product.description;
    priceController.text = product.price.toStringAsFixed(2);
    tags = product.tags;
    isActive = product.status == ProductStatus.active;
    super.onInit();
  }
}

//TODO: ADD try catch for the two apps in all queries
