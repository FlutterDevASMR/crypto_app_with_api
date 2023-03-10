import 'package:crypto_app_wih_api/presentation/bloc/crypto_bloc.dart';
import 'package:crypto_app_wih_api/presentation/bloc/crypto_event.dart';
import 'package:crypto_app_wih_api/presentation/bloc/crypto_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  Color backgroundColor = const Color.fromRGBO(25, 25, 27, 1);
  Color pinkColor = const Color.fromRGBO(254, 83, 152, 1);
  Color greenColor = const Color.fromRGBO(9, 251, 211, 1);
  Color yellowColor = Colors.amberAccent;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CryptoBloc>(context).add(LoadCryptoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoading) {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                  color: yellowColor, size: 200),
            );
          }
          if (state is CryptoResponse) {
            return state.either.fold((errorMessage) {
              return Center(child: Text(errorMessage));
            }, (cryptoList) {
              return LiquidPullToRefresh(
                color: pinkColor,
                backgroundColor: backgroundColor,
                onRefresh: () async {
                  return await Future.delayed(const Duration(seconds: 2), () {
                    BlocProvider.of<CryptoBloc>(context)
                        .add(RefeshDataCryptoEvent());
                  });
                },
                child: ListView.builder(
                  itemCount: cryptoList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: GradientBoxBorder(
                          width: 4,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              greenColor,
                              pinkColor,
                            ],
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cryptoList[index].rank.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        title: Text(
                          cryptoList[index].name!,
                          style: TextStyle(color: yellowColor),
                        ),
                        subtitle: Text(
                          cryptoList[index].symbol!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cryptoList[index]
                                      .priceUsd!
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  cryptoList[index]
                                      .changePercent24Hr!
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    color:
                                        (cryptoList[index].changePercent24Hr! >=
                                                0)
                                            ? greenColor
                                            : pinkColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              (cryptoList[index].changePercent24Hr! >= 0)
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              color: (cryptoList[index].changePercent24Hr! >= 0)
                                  ? greenColor
                                  : pinkColor,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            });
          }
          return Container();
        },
      ),
    );
  }
}
