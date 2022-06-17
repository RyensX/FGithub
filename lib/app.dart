import 'package:FGithub/route/login.dart';
import 'package:FGithub/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'Const.dart';
import 'route/main.dart';

void main() {
  runApp(GithubApp());
  setTransparentStatusBar();
}

class GithubApp extends StatelessWidget {
  //TODO 真正全局登陆状态
  bool isLoginTmp = false;

  GithubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConst.appName,
      theme: ThemeData(
        primarySwatch: AppConst.themeColor,
      ),
      builder: FlutterSmartDialog.init(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          //检查登陆状态，没有登陆强制返回
          if (!isLoginTmp) {
            return LoginRoute();
          }
          switch (settings.name) {
            case null:
            case "/":
            case "":
              return LoginRoute();
            case "main":
              return const MainRoute(title: AppConst.appName);
          }
          return const MainRoute(title: AppConst.appName);
        });
      },
    );
  }
}
