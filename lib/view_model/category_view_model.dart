import 'package:flutter/foundation.dart';
import 'package:test_app/model/category_model.dart';
import 'package:test_app/repository/auth_repository.dart';

class CategoryViewModel extends ChangeNotifier {
  List<CategoryModel>? _categoryItems;

  List<CategoryModel>? get categoryItems => _categoryItems;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchCategoryItems() async {
    try {
      final response = await AppRepository().getCategoryItem();

      _categoryItems = response;
      setLoading(false);
    } catch (error) {
      setLoading(false);
      if (kDebugMode) {
        debugPrint(error.toString());
      }
    }
    notifyListeners();
  }
}
