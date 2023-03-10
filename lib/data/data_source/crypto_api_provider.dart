import 'package:dio/dio.dart';

class CryptoApiProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.coincap.io/v2'));

  Future<dynamic> getCryptoData() async {
    var response = await _dio.get('/assets');

    print(response.data);

    return response;
  }
}
