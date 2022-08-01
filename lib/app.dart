import 'package:FGithub/Global.dart';
import 'package:FGithub/route/login.dart';
import 'package:FGithub/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'Const.dart';
import 'net/Github.dart';
import 'route/main.dart';

void main() => GithubApp.init().then((value) => runApp(const GithubApp()));

class GithubApp extends StatelessWidget {
  const GithubApp({Key? key}) : super(key: key);

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
          if (!Github.isLogin()) {
            return LoginRoute();
          }
          switch (settings.name) {
            case null:
            case "/":
            case "":
              return Github.isLogin()
                  //已登陆则直接跳转主页
                  ? const MainRoute(title: AppConst.appName)
                  : LoginRoute();
            case "main":
              return const MainRoute(title: AppConst.appName);
          }
          return const MainRoute(title: AppConst.appName);
        });
      },
    );
  }

  //全局初始化
  static Future init() async {
    //状态栏
    setTransparentStatusBar();
    //全局配置
    await Global.init();
    //接口
    await Github.init();
  }
}
