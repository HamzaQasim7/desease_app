
import 'package:flutter/foundation.dart';
import 'package:test_app/model/feature_slider_model.dart';
import 'package:test_app/repository/auth_repository.dart';


class SliderItemViewModel extends ChangeNotifier {
  List<SliderItemModel>? _sliderItem;

  List<SliderItemModel>? get sliderItem => _sliderItem;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchSliderItem() async {
    try {
      final response = await AppRepository().getSliderItem();

      _sliderItem = response;
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
