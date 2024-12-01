import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  final bool isLoading;
  final bool successful;
  const AppState({required this.isLoading, required this.successful});
}

class AppStateLoggedIn extends AppState {
  // ignore: use_super_parameters
  const AppStateLoggedIn({
    required isLoading,
    required successful,
  }) : super(isLoading: isLoading, successful: successful);

  @override
  List<Object?> get props => [isLoading, successful];
}

class AppStateLoggedOut extends AppState {
  // ignore: use_super_parameters
  const AppStateLoggedOut({
    required isLoading,
    required successful,
  }) : super(isLoading: isLoading, successful: successful);

  @override
  List<Object?> get props => [isLoading, successful];
}
