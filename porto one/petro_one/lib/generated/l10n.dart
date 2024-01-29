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

  /// `Your phone number is required`
  String get validPhone {
    return Intl.message(
      'Your phone number is required',
      name: 'validPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your name is required`
  String get validName {
    return Intl.message(
      'Your name is required',
      name: 'validName',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Make sure of your email`
  String get enterValidateEmail {
    return Intl.message(
      'Make sure of your email',
      name: 'enterValidateEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password should contain at least {pass} characters or numbers`
  String enterValidatePassword(Object pass) {
    return Intl.message(
      'Password should contain at least $pass characters or numbers',
      name: 'enterValidatePassword',
      desc: '',
      args: [pass],
    );
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
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

  /// `Enter a valid verification code`
  String get enterAValidVerificationCode {
    return Intl.message(
      'Enter a valid verification code',
      name: 'enterAValidVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {sr}`
  String welcome(Object sr) {
    return Intl.message(
      'Welcome $sr',
      name: 'welcome',
      desc: '',
      args: [sr],
    );
  }

  /// `-- -- -- ---`
  String get hintPhoneNo {
    return Intl.message(
      '-- -- -- ---',
      name: 'hintPhoneNo',
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

  /// `Forget password`
  String get forgetPassword {
    return Intl.message(
      'Forget password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `New registration`
  String get newRegistration {
    return Intl.message(
      'New registration',
      name: 'newRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Forget password?`
  String get forgetPasswordQ {
    return Intl.message(
      'Forget password?',
      name: 'forgetPasswordQ',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuo {
    return Intl.message(
      'Continue',
      name: 'continuo',
      desc: '',
      args: [],
    );
  }

  /// `Have an account?`
  String get haveAccount {
    return Intl.message(
      'Have an account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `The access code has been sent`
  String get theAccessCodeHasBeenSent {
    return Intl.message(
      'The access code has been sent',
      name: 'theAccessCodeHasBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `A 4-digit code was sent to the WhatsApp application`
  String get a4DigitCodeWasSentToTheWhatsAppApplication {
    return Intl.message(
      'A 4-digit code was sent to the WhatsApp application',
      name: 'a4DigitCodeWasSentToTheWhatsAppApplication',
      desc: '',
      args: [],
    );
  }

  /// `Change Number`
  String get changeNumber {
    return Intl.message(
      'Change Number',
      name: 'changeNumber',
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

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get main {
    return Intl.message(
      'Main',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Connect with us`
  String get connectWithUs {
    return Intl.message(
      'Connect with us',
      name: 'connectWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get termsOfUse {
    return Intl.message(
      'Terms of use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Share the app`
  String get shareTheApp {
    return Intl.message(
      'Share the app',
      name: 'shareTheApp',
      desc: '',
      args: [],
    );
  }

  /// `The password has been changed successfully`
  String get thePasswordHasBeenChangedSuccessfully {
    return Intl.message(
      'The password has been changed successfully',
      name: 'thePasswordHasBeenChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnectionMakeSureOpenedWifi {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnectionMakeSureOpenedWifi',
      desc: '',
      args: [],
    );
  }

  /// `Whats app No Installed`
  String get whatsappNoInstalled {
    return Intl.message(
      'Whats app No Installed',
      name: 'whatsappNoInstalled',
      desc: '',
      args: [],
    );
  }

  /// `You have an account?`
  String get youHaveAnAccount {
    return Intl.message(
      'You have an account?',
      name: 'youHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Select your phone code`
  String get selectYourPhoneCode {
    return Intl.message(
      'Select your phone code',
      name: 'selectYourPhoneCode',
      desc: '',
      args: [],
    );
  }

  /// `{role, select, ar {English} en {العربية} other {اختيار}}`
  String locale(Object role) {
    return Intl.select(
      role,
      {
        'ar': 'English',
        'en': 'العربية',
        'other': 'اختيار',
      },
      name: 'locale',
      desc: '',
      args: [role],
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

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `{days} Day {hours} Hours {minutes} minutes`
  String modificationPeriodTime(Object days, Object hours, Object minutes) {
    return Intl.message(
      '$days Day $hours Hours $minutes minutes',
      name: 'modificationPeriodTime',
      desc: '',
      args: [days, hours, minutes],
    );
  }

  /// `Show`
  String get show {
    return Intl.message(
      'Show',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `Something Error: {e}`
  String somethingErrorE(Object e) {
    return Intl.message(
      'Something Error: $e',
      name: 'somethingErrorE',
      desc: '',
      args: [e],
    );
  }

  /// `name@domain`
  String get hintEmail {
    return Intl.message(
      'name@domain',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get recoverPasswordTitle {
    return Intl.message(
      'Recover Password',
      name: 'recoverPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterPasswordTitle {
    return Intl.message(
      'Enter Password',
      name: 'enterPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enterNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `(OTP) Enter Sent`
  String get otpEnterSent {
    return Intl.message(
      '(OTP) Enter Sent',
      name: 'otpEnterSent',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `(OTP) is wrong!`
  String get otpIsWrong {
    return Intl.message(
      '(OTP) is wrong!',
      name: 'otpIsWrong',
      desc: '',
      args: [],
    );
  }

  /// `**********`
  String get hintPass {
    return Intl.message(
      '**********',
      name: 'hintPass',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been created successfully`
  String get yourAccountHasBeenCreatedSuccessful {
    return Intl.message(
      'Your account has been created successfully',
      name: 'yourAccountHasBeenCreatedSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Successfully registered`
  String get successfullyRegistered {
    return Intl.message(
      'Successfully registered',
      name: 'successfullyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `A password reset email has been sent`
  String get passwordResetEmailSent {
    return Intl.message(
      'A password reset email has been sent',
      name: 'passwordResetEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Make sure email or password`
  String get makeSureEmailOrPassword {
    return Intl.message(
      'Make sure email or password',
      name: 'makeSureEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logout {
    return Intl.message(
      'Log Out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `This number already exists`
  String get thisNumberAlreadyExists {
    return Intl.message(
      'This number already exists',
      name: 'thisNumberAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Password rest email sent`
  String get passwordRestEmailSent {
    return Intl.message(
      'Password rest email sent',
      name: 'passwordRestEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Not have account?`
  String get notHaveAccount {
    return Intl.message(
      'Not have account?',
      name: 'notHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Make sure your email or password`
  String get makeSureYourEmailOrPassword {
    return Intl.message(
      'Make sure your email or password',
      name: 'makeSureYourEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Fill`
  String get fill {
    return Intl.message(
      'Fill',
      name: 'fill',
      desc: '',
      args: [],
    );
  }

  /// `My QR code`
  String get myQrCode {
    return Intl.message(
      'My QR code',
      name: 'myQrCode',
      desc: '',
      args: [],
    );
  }

  /// `QR Code`
  String get qrCode {
    return Intl.message(
      'QR Code',
      name: 'qrCode',
      desc: '',
      args: [],
    );
  }

  /// `Remaining to achieve goal: -509 Liter`
  String get remainingToAchieveGoal509Liter {
    return Intl.message(
      'Remaining to achieve goal: -509 Liter',
      name: 'remainingToAchieveGoal509Liter',
      desc: '',
      args: [],
    );
  }

  /// `Daily Bonus`
  String get dailyBonus {
    return Intl.message(
      'Daily Bonus',
      name: 'dailyBonus',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Bonus`
  String get monthlyBonus {
    return Intl.message(
      'Monthly Bonus',
      name: 'monthlyBonus',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Bonus`
  String get weeklyBonus {
    return Intl.message(
      'Weekly Bonus',
      name: 'weeklyBonus',
      desc: '',
      args: [],
    );
  }

  /// `First Goal`
  String get firstGoal {
    return Intl.message(
      'First Goal',
      name: 'firstGoal',
      desc: '',
      args: [],
    );
  }

  /// `{liter} Liter`
  String literLiter(Object liter) {
    return Intl.message(
      '$liter Liter',
      name: 'literLiter',
      desc: '',
      args: [liter],
    );
  }

  /// `All my fills`
  String get allMyFills {
    return Intl.message(
      'All my fills',
      name: 'allMyFills',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get notFound {
    return Intl.message(
      'Not Found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Monthly target`
  String get monthlyTarget {
    return Intl.message(
      'Monthly target',
      name: 'monthlyTarget',
      desc: '',
      args: [],
    );
  }

  /// `Petrol: {petrol}`
  String petrolPetrol(Object petrol) {
    return Intl.message(
      'Petrol: $petrol',
      name: 'petrolPetrol',
      desc: '',
      args: [petrol],
    );
  }

  /// `Red Petrol: {liter} - Green`
  String redPetrolLiterGreen(Object liter) {
    return Intl.message(
      'Red Petrol: $liter - Green',
      name: 'redPetrolLiterGreen',
      desc: '',
      args: [liter],
    );
  }

  /// `Second Goal`
  String get secondGoal {
    return Intl.message(
      'Second Goal',
      name: 'secondGoal',
      desc: '',
      args: [],
    );
  }

  /// `Third Goal`
  String get thirdGoal {
    return Intl.message(
      'Third Goal',
      name: 'thirdGoal',
      desc: '',
      args: [],
    );
  }

  /// `Fourth Goal`
  String get fourthGoal {
    return Intl.message(
      'Fourth Goal',
      name: 'fourthGoal',
      desc: '',
      args: [],
    );
  }

  /// `Fifth Goal`
  String get fifthGoal {
    return Intl.message(
      'Fifth Goal',
      name: 'fifthGoal',
      desc: '',
      args: [],
    );
  }

  /// `Sixth Goal`
  String get sixthGoal {
    return Intl.message(
      'Sixth Goal',
      name: 'sixthGoal',
      desc: '',
      args: [],
    );
  }

  /// `Petrol Type`
  String get petrolType {
    return Intl.message(
      'Petrol Type',
      name: 'petrolType',
      desc: '',
      args: [],
    );
  }

  /// `Gas Station`
  String get gasStation {
    return Intl.message(
      'Gas Station',
      name: 'gasStation',
      desc: '',
      args: [],
    );
  }

  /// `Worker`
  String get worker {
    return Intl.message(
      'Worker',
      name: 'worker',
      desc: '',
      args: [],
    );
  }

  /// `Liters`
  String get liters {
    return Intl.message(
      'Liters',
      name: 'liters',
      desc: '',
      args: [],
    );
  }

  /// `Total Payment`
  String get totalPayment {
    return Intl.message(
      'Total Payment',
      name: 'totalPayment',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
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
