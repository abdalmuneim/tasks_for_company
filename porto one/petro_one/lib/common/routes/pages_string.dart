part of 'pages.dart';

abstract class PagesString {
  PagesString._();
  static const initial = _Paths.splash;
  static const onBoarding = _Paths.onBoarding;
  static const login = _Paths.login;
  static const forgetPassword = _Paths.forgetPassword;
  static const home = _Paths.home;
  static const fill = _Paths.fill;
  static const profile = _Paths.profile;
}

abstract class _Paths {
  static const splash = '/';
  static const onBoarding = '/onBoarding';
  static const login = '/login';
  static const forgetPassword = '/forgetPassword';
  static const home = '/home';
  static const fill = '/fill';
  static const profile = '/profile';
}
