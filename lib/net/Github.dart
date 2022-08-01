import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';

import '../Global.dart';
import '../models/user.dart';

class Github {
  BuildContext? context;
  late Options _options;

  static Dio dio = Dio(BaseOptions(baseUrl: 'https://api.github.com/'));

  Github([this.context]) {
    _options = Options(extra: {"context": context});
  }

  static Future init() async {
    _setupAuthorizationHeader(Global.profile.authorization);
  }

  static bool isLogin() => dio.options.headers["Authorization"] != null;

  static void _setupAuthorizationHeader(String? authorization) {
    if (authorization != null) {
      dio.options.headers["Authorization"] = authorization;
    }
  }

  Future<User?> login(String userName, String token) async {
    String authorization = "token $token";
    print("请求: authorization=$authorization");
    var r = await dio.get(
      "/user",
      options: _options.copyWith(headers: {"Authorization": authorization}),
    );
    var user = User.fromJson(r.data);
    if (user.login == userName && user.plan != null) {
      //登录成功附上验证请求头
      _setupAuthorizationHeader(authorization);
      Global.profile
        ..userName = userName
        ..authorization = authorization;
      Global.saveProfile();
      return user;
    }
    return null;
  }
}
