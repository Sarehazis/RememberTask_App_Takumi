import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:re_task/features/auth/login_screens.dart';
import 'package:re_task/features/auth/register_screens.dart';
import 'package:re_task/features/home/home_screens.dart';
import 'package:re_task/features/onboarding/screens/onboarding_screens.dart';
import 'package:re_task/features/splash/screens/splash_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Pastikan Firebase sudah diimport

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreens(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreens(),
    ),
  ],
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime') ?? true;

    final user = FirebaseAuth.instance.currentUser;

    // Jika pengguna sudah login, arahkan ke halaman home
    if (user != null) {
      return '/home';
    }

    // Cek halaman yang diminta, jika pengguna belum login dan belum onboarding
    if (state.uri.toString() == '/' && isFirstTime) {
      return '/onboarding';
    } else if (state.uri.toString() == '/' && !isFirstTime) {
      return '/login';
    }

    return null;
  },
);

// Fungsi untuk logout dan mengarahkan ke halaman login
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  context.go('/login');
}
