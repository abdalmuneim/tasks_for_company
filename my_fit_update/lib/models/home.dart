import 'package:flutter/material.dart';
import 'package:my_fit_update/models/dashboard_page_model.dart';
import 'package:my_fit_update/pages/settings.dart';
import 'package:provider/provider.dart';

import '../pages/dashboard_page.dart';

class HomeModel extends ChangeNotifier {
  int currentIndex = 0;
  final screens = [
    ChangeNotifierProvider(
      create: (_) => DashboardPageModel(),
      child: const DashboardPage(),
    ),
    const SettingsPage(),
  ];

  void setCurrentIndex(int val) {
    currentIndex = val;
    notifyListeners();
  }
}
