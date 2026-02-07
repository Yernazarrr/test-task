import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {}

class SendCodeEvent extends AuthEvent {
  final String email;

  const SendCodeEvent(this.email);

  @override
  List<Object> get props => [email];
}

class VerifyCodeEvent extends AuthEvent {
  final String email;
  final String code;

  const VerifyCodeEvent({required this.email, required this.code});

  @override
  List<Object> get props => [email, code];
}

class LogoutEvent extends AuthEvent {}

class RefreshTokenEvent extends AuthEvent {}
