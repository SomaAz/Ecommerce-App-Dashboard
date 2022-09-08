import 'package:getx_ecommerce_dashboard/core/constants/repoisotries.dart';
import 'package:getx_ecommerce_dashboard/data/model/categoy_model.dart';

abstract class CategoriesRepositoryBase {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoriesRepository extends CategoriesRepositoryBase {
  CategoriesRepository._();

  static final instance = CategoriesRepository._();

  static final _categoriesCollection = firestore.collection("categories");

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final query = _categoriesCollection.orderBy("name");

    final snapshot = await query.get();

    final docs = snapshot.docs;

    final categories =
        docs.map((doc) => CategoryModel.fromMap(doc.data())).toList();

    return categories;
  }
}
