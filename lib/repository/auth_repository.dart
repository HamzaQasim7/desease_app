import 'package:flutter/material.dart';
import 'package:test_app/data/network/base_api_services.dart';
import 'package:test_app/data/network/network_api_services.dart';
import 'package:test_app/model/category_model.dart';
import 'package:test_app/model/feature_slider_model.dart';
import 'package:test_app/model/sub_user_profile_model.dart';
import 'package:test_app/model/user_profile_model.dart';
import 'package:test_app/resources/component/app_url.dart';
import 'package:test_app/view_model/category_view_model.dart';

class AppRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<UserProfileModel> getUserProfile() async {
    try {
      final dynamic response = await _apiService.getGetApiResponse(
          AppUrl.userProfileUrl, '68487fb60b8640b96fe2ae46181f53492a09c283');
      // debugPrint('API Response: $response');

      // Parse JSON to UserProfileModel
      final profileModel = UserProfileModel.fromJson(response);
      return profileModel;
    } catch (e) {
      debugPrint('Error fetching lead detail: $e');
      rethrow;
    }
  }

  Future<List<SliderItemModel>> getSliderItem() async {
    try {
      final dynamic response = await _apiService.getGetApiResponse(
          AppUrl.sliderImageUrl,
          '68487fb60b8640b96fe2ae46181f53492a09c283');
      // debugPrint('API Response: $response');

      // Parse JSON to a list of SliderItemModel
      final List<SliderItemModel> sliderModels = (response as List)
          .map((item) => SliderItemModel.fromJson(item))
          .toList();

      return sliderModels;
    } catch (e) {
      debugPrint('Error fetching slider items: $e');
      rethrow;
    }
  }
  Future<List<SubUserModel>> getSubUsers() async {
    try {
      final dynamic response = await _apiService.getGetApiResponse(
        AppUrl.subUserProfileUrl,
        '68487fb60b8640b96fe2ae46181f53492a09c283',
      );
      // debugPrint('Sub User API Response: $response');

      // Parse JSON to a list of SubUserModel
      final List<SubUserModel> subUsersModel = (response as List<dynamic>)
          .map((item) => SubUserModel.fromJson(item))
          .toList();

      return subUsersModel;
    } catch (e) {
      debugPrint('Error fetching sub users: $e');
      rethrow;
    }
  }

  Future<List<CategoryModel>> getCategoryItem() async {
    try {
      final dynamic response = await _apiService.getGetApiResponse(
          AppUrl.categoryUrl,
          '68487fb60b8640b96fe2ae46181f53492a09c283');
      final List<CategoryModel> categoryModels = (response as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
      return categoryModels;
    } catch (e) {
      debugPrint('Error fetching category items: $e');
      rethrow;
    }
  }







}
