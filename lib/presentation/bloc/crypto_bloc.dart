import 'package:bloc/bloc.dart';
import 'package:crypto_app_wih_api/data/models/crypto_model.dart';
import 'package:crypto_app_wih_api/data/repositories/crypto_repository.dart';
import 'package:crypto_app_wih_api/locator.dart';
import 'package:crypto_app_wih_api/presentation/bloc/crypto_event.dart';
import 'package:crypto_app_wih_api/presentation/bloc/crypto_state.dart';
import 'package:dartz/dartz.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoRepository cryptoRepository = locator();

  CryptoBloc() : super(CryptoLoading()) {
    on<LoadCryptoEvent>((event, emit) async {
      emit(CryptoLoading());

      Either<String, List<CryptoModel>> either =
          await cryptoRepository.fetchCryptoData();

      emit(CryptoResponse(either));
    });

    on<RefeshDataCryptoEvent>((event, emit) async {
      Either<String, List<CryptoModel>> either =
          await cryptoRepository.fetchCryptoData();

      emit(CryptoResponse(either));
    });
  }
}
