import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setTransparentStatusBar() {
  SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}
