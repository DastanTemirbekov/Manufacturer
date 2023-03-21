import 'package:dio/dio.dart';
import 'package:test_project/internal/helpers/catch_exceptions_helper.dart';

class ApiRequester {
  final String url = 'https://vpic.nhtsa.dot.gov/api/';

  Future<Dio> initDio() async {
    return Dio(
      BaseOptions(
        baseUrl: url,
        responseType: ResponseType.json,
        // contentType: 'application/json; charset=utf-8',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  Future<Response> toGet(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();

    try {
      return dio.get(
        url,
        queryParameters: param,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      print('get error ==== $e');

      throw CatchException.convertException(e);
    }
  }

  Future<Response> toPost(String url, {Map<String, dynamic>? param}) async {
    Dio dio = await initDio();

    try {
      return dio.post(url, queryParameters: param);
    } catch (e) {
      print('post error ==== $e');

      throw CatchException.convertException(e);
    }
  }
}
