import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_app/data/app_exceptions.dart';
import 'package:test_app/data/network/base_api_services.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url, String token) async {
    dynamic responseJson;
    try {
      final headers = {
        'Authorization': 'Token $token'
      };

      final response = await http.get(
          Uri.parse(url),
          headers: headers
      ).timeout(const Duration(seconds: 15));
      // print(responseJson);
      responseJson = returnResponse(response);

      // // Assuming `LeadModel.fromJson` is a factory constructor to create a LeadModel from JSON
      // final leadModel = LeadModel.fromJson(responseJson);
      // return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnautherisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server-with status code${response.statusCode}');
    }
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(
        Uri.parse(url),
        body: data,
      )
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
}
