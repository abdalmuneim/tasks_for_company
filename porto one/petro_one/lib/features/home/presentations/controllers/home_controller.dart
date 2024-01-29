import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late PageController pageController = PageController(initialPage: currentPage);
  int currentPage = 0;
  int activeStep = 0;

  pageViewChange(int index) {
    currentPage = index;
    update();
  }

  onTapNext(int index) {
    currentPage = index;
    pageController.animateToPage(currentPage,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
    update();
  }

  void onStepReached(int index) {
    activeStep = index;
    update();
  }
}
