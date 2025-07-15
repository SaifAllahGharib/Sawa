// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get labelEmail {
    return Intl.message('Email', name: 'labelEmail', desc: '', args: []);
  }

  /// `example@ex.ex`
  String get hintEmail {
    return Intl.message('example@ex.ex', name: 'hintEmail', desc: '', args: []);
  }

  /// `Password`
  String get labelPassword {
    return Intl.message('Password', name: 'labelPassword', desc: '', args: []);
  }

  /// `************`
  String get hintPassword {
    return Intl.message(
      '************',
      name: 'hintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Don't have an account`
  String get doNotHaveAnAccount {
    return Intl.message(
      'Don\'t have an account',
      name: 'doNotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `email not valid`
  String get emailNotValid {
    return Intl.message(
      'email not valid',
      name: 'emailNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Must be 8+ chars with uppercase, number & symbol`
  String get passwordValidationMsg {
    return Intl.message(
      'Must be 8+ chars with uppercase, number & symbol',
      name: 'passwordValidationMsg',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Name`
  String get labelName {
    return Intl.message('Name', name: 'labelName', desc: '', args: []);
  }

  /// `Saif Allah`
  String get hintName {
    return Intl.message('Saif Allah', name: 'hintName', desc: '', args: []);
  }

  /// `If you have an account`
  String get ifYouHaveAnAccount {
    return Intl.message(
      'If you have an account',
      name: 'ifYouHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message('Required', name: 'required', desc: '', args: []);
  }

  /// `Email already used`
  String get email_already_used {
    return Intl.message(
      'Email already used',
      name: 'email_already_used',
      desc: '',
      args: [],
    );
  }

  /// `Password Weak`
  String get weakPassword {
    return Intl.message(
      'Password Weak',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `User not exists or email or password incorrect`
  String get userNotFound {
    return Intl.message(
      'User not exists or email or password incorrect',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `This account is disabled`
  String get thisAccountIsDisabled {
    return Intl.message(
      'This account is disabled',
      name: 'thisAccountIsDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Account exists with different method`
  String get accountExistsWithDifferentMethod {
    return Intl.message(
      'Account exists with different method',
      name: 'accountExistsWithDifferentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Error to connect the network`
  String get errorToConnectTheNetwork {
    return Intl.message(
      'Error to connect the network',
      name: 'errorToConnectTheNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Verification Link Sent to`
  String get sendLinkVerificationYourEmailTo {
    return Intl.message(
      'Verification Link Sent to',
      name: 'sendLinkVerificationYourEmailTo',
      desc: '',
      args: [],
    );
  }

  /// `Resend Email`
  String get resendEmail {
    return Intl.message(
      'Resend Email',
      name: 'resendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Code sent successfully`
  String get codeSendSuccess {
    return Intl.message(
      'Code sent successfully',
      name: 'codeSendSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Code not sent successfully`
  String get codeSendNotSuccess {
    return Intl.message(
      'Code not sent successfully',
      name: 'codeSendNotSuccess',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
