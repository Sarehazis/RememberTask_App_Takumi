import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:re_task/features/auth/bloc/app_event.dart';
import 'package:re_task/features/auth/bloc/app_state.dart';
import 'package:re_task/features/auth/data/auth_error.dart';
import 'package:re_task/features/auth/data/auth_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(const AppStateLoggedOut(isLoading: false, successful: false)) {
    on<AppEventLogIn>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().signInWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(const AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        authErrorlogin = e.toString();
        emit(const AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventLogOut>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().signOut();
        emit(const AppStateLoggedOut(isLoading: false, successful: true));
        // ignore: empty_catches
      } on FirebaseAuthException {}
    });

    on<AppEventRegister>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(const AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        authErrorRegister = e.toString();
        emit(const AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventResetPassword>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().sendResetPasswordEmail(email: event.email);
        emit(const AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        authErrorlogin = e.toString();
        emit(const AppStateLoggedOut(isLoading: false, successful: false));
      }
    });
  }
}
