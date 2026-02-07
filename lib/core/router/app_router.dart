import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/features/auth/presentation/pages/login_page.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/code_verification_page.dart';
import '../../features/auth/presentation/pages/home_page.dart';

class AppRouter {
  static const String emailInput = '/';
  static const String codeVerification = '/verification';
  static const String home = '/home';

  static GoRouter createRouter(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: emailInput,
      redirect: (context, state) {
        final authState = authBloc.state;
        final isEmailInput = state.matchedLocation == emailInput;
        final isCodeVerification = state.matchedLocation == codeVerification;
        final isHome = state.matchedLocation == home;

        if (authState is Authenticated) {
          if (!isHome) {
            return home;
          }
        } else if (authState is CodeSent) {
          if (!isCodeVerification) {
            return codeVerification;
          }
        } else if (authState is Unauthenticated) {
          if (!isEmailInput) {
            return emailInput;
          }
        }

        return null;
      },
      refreshListenable: GoRouterRefreshStream(authBloc.stream),
      routes: [
        GoRoute(
          path: emailInput,
          builder: (context, state) {
            return BlocProvider.value(
              value: authBloc,
              child: const LoginPage(),
            );
          },
        ),
        GoRoute(
          path: codeVerification,
          builder: (context, state) {
            return BlocProvider.value(
              value: authBloc,
              child: const CodeVerificationPage(email: ''),
            );
          },
        ),
        GoRoute(
          path: home,
          builder: (context, state) {
            return BlocProvider.value(
              value: authBloc,
              child: const HomePage(userId: ''),
            );
          },
        ),
      ],
    );
  }
}

// Helper class to refresh GoRouter when AuthBloc state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
