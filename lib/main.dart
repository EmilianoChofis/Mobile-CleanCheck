import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_clean_check/core/app.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");


  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthRepository>(
        create: (context) => AuthRepository(),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}
