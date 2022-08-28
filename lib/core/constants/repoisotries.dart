import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_ecommerce_dashboard/data/repository/admins_respository.dart';

class AppRepositories {
  static final adminsRepository = AdminsRepository.instance;
}

final firestore = FirebaseFirestore.instance;
