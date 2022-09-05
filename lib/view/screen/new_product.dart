import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecommerce_dashboard/controller/new_product_controller.dart';
import 'package:getx_ecommerce_dashboard/core/functions/functions.dart';
import 'package:getx_ecommerce_dashboard/data/model/categoy_model.dart';
import 'package:getx_ecommerce_dashboard/view/widget/auth/custom_textformfield.dart';
import 'package:getx_ecommerce_dashboard/view/widget/custom_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/filter_dropdown_button.dart';
import 'package:getx_ecommerce_dashboard/view/widget/gap.dart';
import 'package:getx_ecommerce_dashboard/view/widget/loading.dart';
import 'package:getx_ecommerce_dashboard/view/widget/tag_widget.dart';

class NewProductScreen extends StatelessWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add product"),
      ),
      body: GetBuilder<NewProductController>(
        builder: (controller) {
          if (controller.isLoading) return const Loading();
          return Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              children: [
                CustomTextFormField(
                  controller: controller.nameController,
                  labelText: "Name",
                  hintText: "Type Here",
                  validator: (value) {
                    return AppFunctions.validateField(value, max: 80);
                  },
                ),
                const GapH(25),
                CustomTextFormField(
                  controller: controller.descriptionController,
                  labelText: "Description",
                  hintText: "Type Here",
                  maxLines: 4,
                  maxLength: 320,
                  validator: (value) {
                    return AppFunctions.validateField(value);
                  },
                ),
                const GapH(25),
                CustomTextFormField(
                  controller: controller.priceController,
                  labelText: "Price",
                  hintText: "Type Here",
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (double.tryParse(value) == null) {
                        return "Only Allowed Numbers For Price";
                      }
                    } else {
                      return "This Field Can't Be Empty";
                    }
                    return null;
                  },
                ),
                const GapH(25),
                Form(
                  key: controller.tagsFormKey,
                  child: CustomTextFormField(
                    controller: controller.tagsController,
                    labelText: "Tags",
                    hintText: "Type Here",
                    icon: Icons.add_circle,
                    onTapIcon: () {
                      controller.addTag();
                    },
                    validator: (value) {
                      return AppFunctions.validateField(value, max: 24);
                    },
                  ),
                ),
                TagsBuilder(
                  controller.tags,
                  onTagPressed: (value) {
                    controller.removeTag(value);
                  },
                ),
                const GapH(25),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                  ),
                  child: DropdownButton<CategoryModel>(
                    value: controller.category,
                    items: List.generate(
                      controller.categories.length,
                      (index) => DropdownMenuItem(
                        value: controller.categories[index],
                        child: Text(
                          controller.categories[index].name.capitalizeFirst!,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) controller.setCategory(value);
                    },
                    underline: const Gap(),
                  ),
                ),
                const GapH(25),
                GestureDetector(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: controller.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: Get.height * .22,
                            child: Image.file(controller.image!),
                          ),
                        )
                      : Container(
                          height: Get.height * .22,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add image",
                                style: Get.textTheme.headline5,
                              ),
                              const GapH(4),
                              const Icon(Icons.image),
                            ],
                          ),
                        ),
                ),
                const GapH(25),
                Row(
                  children: [
                    Checkbox(
                      value: controller.isActive,
                      onChanged: (value) {
                        if (value != null) {
                          controller.setIsActive(value);
                        }
                      },
                      activeColor: Get.theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Text("Is Product Active", style: Get.textTheme.headline6),
                  ],
                ),
                const GapH(25),
                controller.isAddingProductLoading
                    ? const Loading()
                    : CustomButton(
                        text: "Add Product",
                        onPressed: () {
                          controller.addProduct();
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
