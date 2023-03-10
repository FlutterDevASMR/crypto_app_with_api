import 'package:crypto_app_wih_api/data/data_source/crypto_api_provider.dart';
import 'package:crypto_app_wih_api/data/repositories/crypto_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() {
  //api providers
  locator.registerSingleton<CryptoApiProvider>(CryptoApiProvider());

  //repositories
  locator.registerSingleton<CryptoRepository>(CryptoRepository());
}
