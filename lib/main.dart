import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_clean_check/core/app.dart';
import 'package:mobile_clean_check/data/repositories/repositories.dart';
import 'package:mobile_clean_check/data/cubits/cubits.dart';

void main() {
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<AuthRepository>(
        create: (context) => AuthRepository(),
      ),
      RepositoryProvider<BuildingRepository>(
        create: (context) => BuildingRepository(),
      ),
      RepositoryProvider<FloorRepository>(
        create: (context) => FloorRepository(),
      ),
      RepositoryProvider<RoomRepository>(
        create: (context) => RoomRepository(),
      ),
      RepositoryProvider<UserRepository>(
        create: (context) => UserRepository(),
      ),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<BuildingCubit>(
          create: (context) => BuildingCubit(
            buildingRepository: context.read<BuildingRepository>(),
          ),
        ),
        BlocProvider<FloorCubit>(
          create: (context) => FloorCubit(
            floorRepository: context.read<FloorRepository>(),
          ),
        ),
        BlocProvider<RoomCubit>(
          create: (context) => RoomCubit(
            roomRepository: context.read<RoomRepository>(),
          ),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}
