class KeyConst {
  static KeyConst? _instance;
  // Avoid self instance
  KeyConst._();
  static KeyConst get instance => _instance ??= KeyConst._();

  String get token =>
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiYWJvbGljMDJAZ21haWwuY29tIiwibmFtZSI6IkFiZGFsbXVuZWltIG1haG1vdWQiLCJBUElfVElNRSI6MTcwMjAzODI5OH0.iNPEZ2AyeFhBM_6aXERZHNNrkrediYqexMthPx6a_l8	';
}
