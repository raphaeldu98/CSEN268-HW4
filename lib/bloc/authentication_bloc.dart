import 'package:bloc/bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

class AuthenticationEvent {}

class AuthenticationBloc extends Cubit<AuthenticationStatus> {
  AuthenticationBloc() : super(AuthenticationStatus.unauthenticated);

  void login() => emit(AuthenticationStatus.authenticated);
  void logout() => emit(AuthenticationStatus.unauthenticated);
}