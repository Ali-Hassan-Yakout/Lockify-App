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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Locked`
  String get locked {
    return Intl.message(
      'Locked',
      name: 'locked',
      desc: '',
      args: [],
    );
  }

  /// `Unlocked`
  String get unlocked {
    return Intl.message(
      'Unlocked',
      name: 'unlocked',
      desc: '',
      args: [],
    );
  }

  /// `Unlock`
  String get unlock {
    return Intl.message(
      'Unlock',
      name: 'unlock',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password Required`
  String get passwordRequired {
    return Intl.message(
      'Password Required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please turn on Bluetooth!`
  String get pleaseTurnOnBluetooth {
    return Intl.message(
      'Please turn on Bluetooth!',
      name: 'pleaseTurnOnBluetooth',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Password`
  String get invalidPassword {
    return Intl.message(
      'Invalid Password',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Not connected to smart lock`
  String get notConnectedToSmartLock {
    return Intl.message(
      'Not connected to smart lock',
      name: 'notConnectedToSmartLock',
      desc: '',
      args: [],
    );
  }

  /// `Error sending unlock command`
  String get errorSendingUnlockCommand {
    return Intl.message(
      'Error sending unlock command',
      name: 'errorSendingUnlockCommand',
      desc: '',
      args: [],
    );
  }

  /// `Manage Access`
  String get manageAccess {
    return Intl.message(
      'Manage Access',
      name: 'manageAccess',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint`
  String get fingerprint {
    return Intl.message(
      'Fingerprint',
      name: 'fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `RFID`
  String get rfid {
    return Intl.message(
      'RFID',
      name: 'rfid',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Current Password required!`
  String get currentPasswordRequired {
    return Intl.message(
      'Current Password required!',
      name: 'currentPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Too Short`
  String get tooShort {
    return Intl.message(
      'Too Short',
      name: 'tooShort',
      desc: '',
      args: [],
    );
  }

  /// `New Password required!`
  String get newPasswordRequired {
    return Intl.message(
      'New Password required!',
      name: 'newPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password Changed`
  String get passwordChanged {
    return Intl.message(
      'Password Changed',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Password Change Failed`
  String get passwordChangeFailed {
    return Intl.message(
      'Password Change Failed',
      name: 'passwordChangeFailed',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprints`
  String get fingerprints {
    return Intl.message(
      'Fingerprints',
      name: 'fingerprints',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add Fingerprint`
  String get addFingerprint {
    return Intl.message(
      'Add Fingerprint',
      name: 'addFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Username required!`
  String get usernameRequired {
    return Intl.message(
      'Username required!',
      name: 'usernameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Details required!`
  String get detailsRequired {
    return Intl.message(
      'Details required!',
      name: 'detailsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Command Failed`
  String get commandFailed {
    return Intl.message(
      'Command Failed',
      name: 'commandFailed',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint Stored`
  String get fingerprintStored {
    return Intl.message(
      'Fingerprint Stored',
      name: 'fingerprintStored',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint Storage Failed`
  String get fingerprintStorageFailed {
    return Intl.message(
      'Fingerprint Storage Failed',
      name: 'fingerprintStorageFailed',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint Deleted`
  String get fingerprintDeleted {
    return Intl.message(
      'Fingerprint Deleted',
      name: 'fingerprintDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Fingerprint Delete Failed`
  String get fingerprintDeleteFailed {
    return Intl.message(
      'Fingerprint Delete Failed',
      name: 'fingerprintDeleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Obtaining Fingerprints Failed`
  String get obtainingFingerprintsFailed {
    return Intl.message(
      'Obtaining Fingerprints Failed',
      name: 'obtainingFingerprintsFailed',
      desc: '',
      args: [],
    );
  }

  /// `RFIDs`
  String get rfids {
    return Intl.message(
      'RFIDs',
      name: 'rfids',
      desc: '',
      args: [],
    );
  }

  /// `UID`
  String get uid {
    return Intl.message(
      'UID',
      name: 'uid',
      desc: '',
      args: [],
    );
  }

  /// `Add RFID`
  String get addRfid {
    return Intl.message(
      'Add RFID',
      name: 'addRfid',
      desc: '',
      args: [],
    );
  }

  /// `RFID Stored`
  String get rfidStored {
    return Intl.message(
      'RFID Stored',
      name: 'rfidStored',
      desc: '',
      args: [],
    );
  }

  /// `RFID Storage Failed`
  String get rfidStorageFailed {
    return Intl.message(
      'RFID Storage Failed',
      name: 'rfidStorageFailed',
      desc: '',
      args: [],
    );
  }

  /// `RFID Deleted`
  String get rfidDeleted {
    return Intl.message(
      'RFID Deleted',
      name: 'rfidDeleted',
      desc: '',
      args: [],
    );
  }

  /// `RFID Delete Failed`
  String get rfidDeleteFailed {
    return Intl.message(
      'RFID Delete Failed',
      name: 'rfidDeleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Obtaining RFIDs Failed`
  String get obtainingRfidsFailed {
    return Intl.message(
      'Obtaining RFIDs Failed',
      name: 'obtainingRfidsFailed',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have an account`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t Have an account',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email required!`
  String get emailRequired {
    return Intl.message(
      'Email required!',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Credentials!`
  String get invalidCredentials {
    return Intl.message(
      'Invalid Credentials!',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Internet!`
  String get checkYourInternet {
    return Intl.message(
      'Check Your Internet!',
      name: 'checkYourInternet',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset password email sent to your account`
  String get resetPasswordEmailSentToYourAccount {
    return Intl.message(
      'Reset password email sent to your account',
      name: 'resetPasswordEmailSentToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password Failed`
  String get resetPasswordFailed {
    return Intl.message(
      'Reset Password Failed',
      name: 'resetPasswordFailed',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation required!`
  String get confirmationRequired {
    return Intl.message(
      'Confirmation required!',
      name: 'confirmationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Those password didn't match`
  String get thosePasswordDidntMatch {
    return Intl.message(
      'Those password didn\'t match',
      name: 'thosePasswordDidntMatch',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Account Created`
  String get accountCreated {
    return Intl.message(
      'Account Created',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak`
  String get thePasswordProvidedIsTooWeak {
    return Intl.message(
      'The password provided is too weak',
      name: 'thePasswordProvidedIsTooWeak',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email`
  String get theAccountAlreadyExistsForThatEmail {
    return Intl.message(
      'The account already exists for that email',
      name: 'theAccountAlreadyExistsForThatEmail',
      desc: '',
      args: [],
    );
  }

  /// `Registration Failed`
  String get registrationFailed {
    return Intl.message(
      'Registration Failed',
      name: 'registrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Delete Fingerprint`
  String get deleteFingerprint {
    return Intl.message(
      'Delete Fingerprint',
      name: 'deleteFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Delete RFID`
  String get deleteRfid {
    return Intl.message(
      'Delete RFID',
      name: 'deleteRfid',
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
