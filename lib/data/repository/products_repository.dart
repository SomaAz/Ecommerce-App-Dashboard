import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/data/model/product_model.dart';

abstract class ProductsRepositoryBase {
  Future<List<ProductModel>> getAllProducts();
  Future<void> deleteProduct(ProductModel deletedProduct);
  Future<String> uploadProductImage(File image, String productId);
  Future<void> addProduct(ProductModel productDetails, File image);
  Future<void> editProduct(ProductModel productDetails, File? image);
}

class ProductsRepository extends ProductsRepositoryBase {
  ProductsRepository._();

  static final instance = ProductsRepository._();

  static final _productsCollection = firestore.collection("products");

  @override
  Future<List<ProductModel>> getAllProducts({
    int limit = 6,
    Timestamp? startAfterProductCreationDate,
    String? startAfterProductName,
  }) async {
    var query = _productsCollection.orderBy("name").limit(limit);
    // .startAfter([startAfterProductName]);

    if (startAfterProductName != null) {
      query = query.startAfter([startAfterProductName]);
    }

    // if (limit != null) {
    //   query = query.limit(limit);
    // }

    final snapshot = await query.get();

    final products = snapshot.docs
        .map(
          (doc) => ProductModel.fromMap(doc.data()),
        )
        .toList();
    return products;
  }

  @override
  Future<void> deleteProduct(ProductModel deletedProduct) async {
    final doc = _productsCollection.doc(deletedProduct.id);
    await doc.delete();
  }

  @override
  Future<String> uploadProductImage(File image, String productId) async {
    return await firebaseStorage
        .ref("products")
        .child(productId)
        .putFile(image)
        .then(
          (uploadTask) async => await uploadTask.ref.getDownloadURL(),
        );
  }

  @override
  Future<void> addProduct(ProductModel productDetails, File image) async {
    final docRef = _productsCollection.doc();

    final imageUrl = await uploadProductImage(image, docRef.id);

    ProductModel addedProduct = productDetails.copyWith(
      id: docRef.id,
      image: imageUrl,
      timeCreated: Timestamp.now(),
    );

    await docRef.set(addedProduct.toMap());
  }

  @override
  Future<void> editProduct(ProductModel productDetails, File? image) async {
    final docRef = _productsCollection.doc(productDetails.id);

    String? imageUrl;

    if (image != null) {
      imageUrl = await uploadProductImage(image, docRef.id);
    }

    await docRef.update(
      productDetails.copyWith(image: imageUrl ?? productDetails.image).toMap(),
    );
  }
}
