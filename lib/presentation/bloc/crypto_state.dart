import 'package:crypto_app_wih_api/data/models/crypto_model.dart';
import 'package:dartz/dartz.dart';

abstract class CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoResponse extends CryptoState {
  Either<String, List<CryptoModel>> either;

  CryptoResponse(this.either);
}
