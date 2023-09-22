import 'package:flutter/foundation.dart';
import 'package:test_app/model/sub_user_profile_model.dart';
import 'package:test_app/repository/auth_repository.dart';

class SubUserViewModel extends ChangeNotifier {
  List<SubUserModel>? _subUsers; // Change to a list

  List<SubUserModel>? get subUsers => _subUsers; // Getter should also return a list

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchSubUsers() async { // Rename to fetchSubUsers
    try {
      final response = await AppRepository().getSubUsers();
      _subUsers = response;
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
