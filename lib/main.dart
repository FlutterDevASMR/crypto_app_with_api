import 'package:crypto_app_wih_api/locator.dart';
import 'package:crypto_app_wih_api/presentation/bloc/crypto_bloc.dart';
import 'package:crypto_app_wih_api/presentation/screens/crypto_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CryptoBloc(),
        child: const CryptoScreen(),
      ),
    );
  }
}
