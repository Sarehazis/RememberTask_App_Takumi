import 'package:bloc/bloc.dart';
import 'package:re_task/features/splash/bloc/splash_event.dart';
import 'package:re_task/features/splash/bloc/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<CheckUserStatus>(_onCheckUserStatus);
  }

  Future<void> _onCheckUserStatus(
      CheckUserStatus event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    final prefs = await SharedPreferences.getInstance();

    // Untuk memeriksa apakah pengguna pertama kali membuka aplikasi

    final isFirstTime = prefs.getBool('isFirstTime') ?? true;
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isFirstTime) {
      emit(SplashNavigateToOnboarding());
    } else if (!isLoggedIn) {
      emit(SplashNavigateToLogin());
    } else {
      emit(SplashNavigateToHome());
    }
  }
}
