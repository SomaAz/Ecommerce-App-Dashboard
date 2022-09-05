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

class NewProductController extends GetxController {
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
      category = categories.first;
    }
    setIsLoading(false);
  }

  bool isAddingProductLoading = false;
  void setIsAddingProductLoading(bool value) {
    isAddingProductLoading = value;
    update();
  }

  Future<void> addProduct() async {
    if (image == null) {
      AppFunctions.showErrorSnackBar(
        text: "You should add an image for the product",
      );
    }
    if (formKey.currentState!.validate() && category != null) {
      AppFunctions.showOkCancelDialog(
        text: "Are you sure you want to add this product to the store",
        onConfirm: () async {
          final product = ProductModel(
            id: "",
            name: nameController.text.trim(),
            description: descriptionController.text.trim(),
            category: category!.id,
            categoryName: category!.name,
            image: "image",
            brand: "brand",
            sizes: [],
            favorites: [],
            tags: tags,
            colors: [],
            price: double.parse(priceController.text.trim()),
            status: isActive ? ProductStatus.active : ProductStatus.disabled,
            timeCreated: Timestamp.now(),
          );

          try {
            setIsAddingProductLoading(true);
            await AppRepositories.productsRepository
                .addProduct(product, image!);

            // Note: No need for refreshing because of the pagination
            // await Get.find<ProductsController>().refreshData();
            //

            Get.find<ProductsController>().setHasNextPage(true);
          } catch (e) {
            AppFunctions.showErrorSnackBar(text: "$e");
          } finally {
            setIsAddingProductLoading(false);
          }
        },
      );
    }
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }
}

//TODO: ADD try catch for the two apps in all queries
