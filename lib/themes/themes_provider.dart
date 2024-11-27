import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'darkMode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  //initialy light mode
  ThemeData _themeData = lightMode;

  //get theme
ThemeData get themeData => _themeData;

//is dark
  bool get isDarkMode => themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;
    //update ui
    notifyListeners();
  }


  //toggle theme
void toggleTheme() {
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
}
}