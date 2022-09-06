import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:getx_ecommerce_dashboard/core/enums/product_status.dart';
import 'package:getx_ecommerce_dashboard/data/model/cart_product_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String categoryName;
  final String image;
  final String brand;
  final List<String> sizes;
  final List<String> tags;
  List<String> favorites;
  final List<Color> colors;
  final double price;
  final ProductStatus status;
  final Timestamp timeCreated;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.categoryName,
    required this.image,
    required this.brand,
    required this.sizes,
    required this.favorites,
    required this.tags,
    required this.colors,
    required this.price,
    required this.status,
    required this.timeCreated,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? categoryName,
    String? image,
    String? brand,
    List<String>? sizes,
    List<String>? favorites,
    List<String>? tags,
    List<Color>? colors,
    double? price,
    ProductStatus? status,
    Timestamp? timeCreated,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      categoryName: categoryName ?? this.categoryName,
      image: image ?? this.image,
      brand: brand ?? this.brand,
      sizes: sizes ?? this.sizes,
      favorites: favorites ?? this.favorites,
      tags: tags ?? this.tags,
      colors: colors ?? this.colors,
      price: price ?? this.price,
      status: status ?? this.status,
      timeCreated: timeCreated ?? this.timeCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'categoryName': categoryName,
      'brand': brand,
      'image': image,
      'sizes': sizes,
      'favorites': favorites,
      'tags': tags,
      'colors': colors.map((e) => e.value).toList(),
      'price': price,
      'status': status.name,
      'timeCreated': timeCreated,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      categoryName: map['categoryName'] ?? '',
      brand: map['brand'] ?? '',
      image: map['image'] ?? '',
      sizes: List.from(map['sizes'] ?? []),
      favorites: List.from(map['favorites'] ?? []),
      tags: List.from(map['tags'] ?? []),
      colors: List<int>.from(map['colors'] ?? [])
          .map((colornum) => Color(colornum))
          .toList(),
      price: map['price']?.toDouble() ?? 0.0,
      status: ProductStatus.values.firstWhere(
        (value) => value.name == map['status'],
        orElse: () => ProductStatus.values[0],
      ),
      timeCreated: map['timeCreated'] ?? Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  CartProductModel toCartProductModel() {
    return CartProductModel(
      id: id,
      name: name,
      image: image,
      price: price,
      quantity: 1,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, brand: $brand, category: $category, categoryName: $categoryName, image: $image, price: $price, sizes: $sizes, favorites: $favorites, tags: $tags, colors: $colors, status: $status, timeCreated: $timeCreated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.category == category &&
        other.categoryName == categoryName &&
        other.image == image &&
        other.brand == brand &&
        other.sizes == sizes &&
        other.favorites == favorites &&
        other.tags == tags &&
        other.colors == colors &&
        other.price == price &&
        other.status == status &&
        other.timeCreated == timeCreated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        category.hashCode ^
        categoryName.hashCode ^
        image.hashCode ^
        brand.hashCode ^
        tags.hashCode ^
        sizes.hashCode ^
        favorites.hashCode ^
        colors.hashCode ^
        status.hashCode ^
        price.hashCode ^
        timeCreated.hashCode;
  }
}
