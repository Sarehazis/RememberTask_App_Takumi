import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:re_task/features/splash/bloc/splash_bloc.dart';
import 'package:re_task/features/splash/bloc/splash_event.dart';
import 'package:re_task/features/splash/bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(CheckUserStatus()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToOnboarding) {
            context.go('/onboarding');
          } else if (state is SplashNavigateToLogin) {
            context.go('/login');
          } else if (state is SplashNavigateToHome) {
            context.go('/home');
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
