import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

@immutable
class AppEventLogOut extends AppEvent {
  const AppEventLogOut();

  @override
  List<Object?> get props => throw UnimplementedError();
}

@immutable
class AppEventLogIn extends AppEvent {
  final String email;
  final String password;
  const AppEventLogIn({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

@immutable
class AppEventRegister extends AppEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const AppEventRegister({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    // ignore: non_constant_identifier_names
    required String confirm_password,
  });

  @override
  List<Object?> get props => [username, email, password, confirmPassword];
}

@immutable
class AppEventResetPassword extends AppEvent {
  final String email;
  const AppEventResetPassword({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
