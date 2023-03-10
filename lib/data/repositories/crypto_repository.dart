import 'package:crypto_app_wih_api/data/data_source/crypto_api_provider.dart';
import 'package:crypto_app_wih_api/data/models/crypto_model.dart';
import 'package:crypto_app_wih_api/locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class CryptoRepository {
  CryptoApiProvider apiProvider = locator();

  Future<Either<String, List<CryptoModel>>> fetchCryptoData() async {
    Response response = await apiProvider.getCryptoData();

    try {
      if (response.statusCode == 200) {
        List<CryptoModel> cryptoList = response.data['data']
            .map<CryptoModel>((jsonObject) => CryptoModel.fromJson(jsonObject))
            .toList();
        return right(cryptoList);
      } else {
        return left('Please check your connection');
      }
    } catch (ex) {
      return left(ex.toString());
    }
  }
}
