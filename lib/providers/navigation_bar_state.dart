import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationBarState extends ChangeNotifier {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}
