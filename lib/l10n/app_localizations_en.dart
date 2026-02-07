// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Auth App';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get sendCodeButton => 'Send Code';

  @override
  String get codeLabel => 'Verification Code';

  @override
  String get codeHint => 'Enter 6-digit code';

  @override
  String get verifyButton => 'Verify';

  @override
  String get logout => 'Logout';

  @override
  String get authorized => 'Authorized';

  @override
  String userId(String id) {
    return 'User ID: $id';
  }

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get codeRequired => 'Code is required';

  @override
  String get codeMustBe6Digits => 'Code must be 6 digits';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get codeSent => 'Code sent to your email';

  @override
  String enterCodeSent(String email) {
    return 'Enter the code sent to $email';
  }

  @override
  String get resendCode => 'Resend Code';

  @override
  String get backToEmail => 'Back to Email';
}
