import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_authentication.dart';
import '../../domain/usecases/confirm_code.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/refresh_token.dart';
import '../../domain/usecases/send_login_code.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendLoginCode sendLoginCode;
  final ConfirmCode confirmCode;
  final GetUser getUser;
  final Logout logout;
  final CheckAuthentication checkAuthentication;
  final RefreshTokenUseCase refreshTokenUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.sendLoginCode,
    required this.confirmCode,
    required this.getUser,
    required this.logout,
    required this.checkAuthentication,
    required this.refreshTokenUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SendCodeEvent>(_onSendCode);
    on<VerifyCodeEvent>(_onVerifyCode);
    on<LogoutEvent>(_onLogout);
    on<RefreshTokenEvent>(_onRefreshToken);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await checkAuthentication(NoParams());

    await result.fold(
      (failure) async {
        emit(Unauthenticated());
      },
      (isAuthenticated) async {
        if (isAuthenticated) {
          final tokenResult = await authRepository.getStoredAccessToken();
          await tokenResult.fold(
            (failure) async {
              emit(Unauthenticated());
            },
            (token) async {
              if (token != null) {
                final userResult = await getUser(
                  GetUserParams(accessToken: token),
                );
                userResult.fold(
                  (failure) => emit(Unauthenticated()),
                  (user) => emit(Authenticated(user.userId)),
                );
              } else {
                emit(Unauthenticated());
              }
            },
          );
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> _onSendCode(SendCodeEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await sendLoginCode(SendLoginCodeParams(email: event.email));

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(CodeSent(event.email)),
    );
  }

  Future<void> _onVerifyCode(
    VerifyCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await confirmCode(
      ConfirmCodeParams(email: event.email, code: event.code),
    );

    await result.fold(
      (failure) async {
        emit(AuthError(failure.message));
      },
      (tokens) async {
        final userResult = await getUser(
          GetUserParams(accessToken: tokens.accessToken),
        );

        userResult.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(Authenticated(user.userId)),
        );
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await logout(NoParams());

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(Unauthenticated()),
    );
  }

  Future<void> _onRefreshToken(
    RefreshTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    final refreshTokenResult = await authRepository.getStoredRefreshToken();

    await refreshTokenResult.fold(
      (failure) async {
        emit(Unauthenticated());
      },
      (refreshToken) async {
        if (refreshToken != null) {
          final result = await refreshTokenUseCase(
            RefreshTokenParams(refreshToken: refreshToken),
          );

          await result.fold(
            (failure) async {
              emit(Unauthenticated());
            },
            (tokens) async {
              final userResult = await getUser(
                GetUserParams(accessToken: tokens.accessToken),
              );

              userResult.fold(
                (failure) => emit(AuthError(failure.message)),
                (user) => emit(Authenticated(user.userId)),
              );
            },
          );
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }
}
