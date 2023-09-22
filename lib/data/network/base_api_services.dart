


abstract class BaseApiService {
  Future<dynamic> getGetApiResponse(String url, String token);

  Future<dynamic> getPostApiResponse(String url, dynamic data);
}
