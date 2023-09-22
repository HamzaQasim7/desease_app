import 'package:flutter/foundation.dart';

import 'package:test_app/model/user_profile_model.dart';
import 'package:test_app/repository/auth_repository.dart';

class UserProfileViewModel extends ChangeNotifier {

  UserProfileModel? _userProfile;

  UserProfileModel? get userProfile => _userProfile;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  Future<void> fetchUserProfile() async {
    try {
      final response = await AppRepository().getUserProfile();
      if (response != null) {
        // Assuming that response.data is of type LeadModel
        // debugPrint(response.toString());
        _userProfile = response;

      }
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

