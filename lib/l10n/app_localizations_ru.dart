// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Авторизация';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Введите ваш email';

  @override
  String get sendCodeButton => 'Отправить код';

  @override
  String get codeLabel => 'Код подтверждения';

  @override
  String get codeHint => 'Введите 6-значный код';

  @override
  String get verifyButton => 'Подтвердить';

  @override
  String get logout => 'Выйти';

  @override
  String get authorized => 'Авторизован';

  @override
  String userId(String id) {
    return 'ID пользователя: $id';
  }

  @override
  String get invalidEmail => 'Введите корректный email';

  @override
  String get codeRequired => 'Код обязателен';

  @override
  String get codeMustBe6Digits => 'Код должен содержать 6 цифр';

  @override
  String get errorOccurred => 'Произошла ошибка';

  @override
  String get codeSent => 'Код отправлен на вашу почту';

  @override
  String enterCodeSent(String email) {
    return 'Введите код, отправленный на $email';
  }

  @override
  String get resendCode => 'Отправить повторно';

  @override
  String get backToEmail => 'Назад к email';
}
