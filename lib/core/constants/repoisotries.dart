import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:getx_ecommerce_dashboard/data/repository/admins_respository.dart';
import 'package:getx_ecommerce_dashboard/data/repository/categories_repository.dart';
import 'package:getx_ecommerce_dashboard/data/repository/orders_repository.dart';
import 'package:getx_ecommerce_dashboard/data/repository/products_repository.dart';

class AppRepositories {
  AppRepositories._();

  static final adminsRepository = AdminsRepository.instance;
  static final productsRepository = ProductsRepository.instance;
  static final categoriesRepository = CategoriesRepository.instance;
  static final ordersRepository = OrdersRepository.instance;
}

final firestore = FirebaseFirestore.instance;
final firebaseStorage = FirebaseStorage.instance;
