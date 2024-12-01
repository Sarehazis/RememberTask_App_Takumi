import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_task/features/auth/bloc/app_bloc.dart';
import 'package:re_task/features/statistic/bloc/statistic_bloc.dart';
import 'package:re_task/features/statistic/data/statistic_repository.dart';
import 'package:re_task/features/task/bloc/task_bloc.dart';
import 'package:re_task/features/task/data/task_repository.dart';
import 'package:re_task/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => TaskBloc(TaskRepository()),
        ),
        BlocProvider(
          create: (context) => StatisticsBloc(
            repository: StatisticsRepository(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
