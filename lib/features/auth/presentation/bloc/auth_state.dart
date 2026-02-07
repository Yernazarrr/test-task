import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Unauthenticated extends AuthState {}

class CodeSent extends AuthState {
  final String email;

  const CodeSent(this.email);

  @override
  List<Object> get props => [email];
}

class Authenticated extends AuthState {
  final String userId;

  const Authenticated(this.userId);

  @override
  List<Object> get props => [userId];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}
