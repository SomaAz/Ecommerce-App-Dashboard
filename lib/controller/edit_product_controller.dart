import 'dart:developer';
import 'dart:io';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';
import 'package:getx_ecommerce_dashboard/core/functions/functions.dart';
import 'package:getx_ecommerce_dashboard/data/model/categoy_model.dart';
import 'package:getx_ecommerce_dashboard/data/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class EditProductController extends GetxController {
  late final ProductModel product;
  EditProductController();

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
      final fieldsDifferences = productFieldsDifference(editedProduct);
      if (product == editedProduct || fieldsDifferences.isEmpty) {
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

            try {
              Get.back();
              await AppRepositories.productsRepository
                  .editProduct(editedProduct, image);
            } catch (e) {
              AppFunctions.showErrorSnackBar(text: "$e");
            } finally {
              setIsEditingProductLoading(false);
              Get.back();
            }
          },
          text: """Product fields changed:\n$fieldsDifferences""",
        );

        // await Get.find<ProductsController>().refreshData();
      }

      // Get.find<ProductsController>().setHasNextPage(true);
    }
  }

  String? productFieldDifference(valueName, firstValue, secondValue) {
    return firstValue == secondValue
        ? null
        : "$valueName: $firstValue -> $secondValue";
  }

  String productFieldsDifference(ProductModel editedProduct) {
    List<String> differences = [];

    final productMap = product.toMap();
    final editedProductMap = editedProduct.toMap();
    final keys = productMap.keys;

    if (productMap['description'] != editedProductMap['description']) {
      differences.add(
          "description: ${productMap['description']}  -> ${editedProductMap['description']}");
    }

    if (productMap['description'].length > 20) {
      productMap['description'] =
          "${productMap['description'].substring(0, 20)}...";
    }
    if (editedProductMap['description'].length > 20) {
      editedProductMap['description'] =
          "${editedProductMap['description'].substring(0, 20)}...";
    }
    // final values = product.toMap().values;

    for (var key in keys) {
      if (productMap[key] is List) {
        final List value = productMap[key];
        if (!value.equals(editedProductMap[key])) {
          differences
              .add("$key: ${productMap[key]}  -> ${editedProductMap[key]}");
        }
        continue;
      }
      if (key != "description") {
        final difference =
            productFieldDifference(key, productMap[key], editedProductMap[key]);
        if (difference != null) {
          differences.add(difference);
        }
      }
    }
    return differences.join("\n");
  }

  @override
  void onInit() {
    loadData();
    product = Get.arguments['product'];
    nameController.text = product.name;
    descriptionController.text = product.description;
    priceController.text = product.price.toStringAsFixed(2);
    tags.addAll(product.tags);
    isActive = product.status == ProductStatus.active;
    super.onInit();
  }
}
