import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';

abstract class AdminsRepositoryBase {
  Future<bool> authenticateAdmin(String email, String password);
}

class AdminsRepository extends AdminsRepositoryBase {
  AdminsRepository._();

  static final instance = AdminsRepository._();

  static final _adminsCollection = firestore.collection("admins");

  @override
  Future<bool> authenticateAdmin(String email, String password) async {
    final query = _adminsCollection
        .where("email", isEqualTo: email)
        .where("password", isEqualTo: password);

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return false;
    }

    return true;
  }
}
