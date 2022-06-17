import 'package:FGithub/Const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class LoginRoute extends StatelessWidget {
  LoginRoute({Key? key}) : super(key: key);

  final TapGestureRecognizer _tapServer = TapGestureRecognizer()
    ..onTap = () {
      SmartDialog.showToast("查看服务条款");
    };
  final TapGestureRecognizer _tapPolicy = TapGestureRecognizer()
    ..onTap = () {
      SmartDialog.showToast("查看隐私协议");
    };

  final TextStyle _linkStyle = const TextStyle(
      color: Color(0xFF1765BD),
      decoration: TextDecoration.underline,
      decorationColor: Color(0xFF1765BD));
  final TextStyle _textStyle = const TextStyle(color: Color(0xFF42434E));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.themeColor.shade50,
      body: const Center(
          //TODO 等换成新图标
          child: FlutterLogo(
        size: 100,
      )),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: MaterialButton(
                  onPressed: () {
                    //TODO
                    Navigator.pushNamed(context, "main");
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(12), child: Text("使用GITHUB账号登陆")),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 2),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(text: "登陆即表示接受我们的 ", style: _textStyle),
                    TextSpan(
                        text: "服务条款",
                        style: _linkStyle,
                        recognizer: _tapServer),
                    TextSpan(
                      text: " 和 ",
                      style: _textStyle,
                    ),
                    TextSpan(
                        text: "隐私政策",
                        style: _linkStyle,
                        recognizer: _tapPolicy),
                    TextSpan(text: ' 。', style: _textStyle),
                  ])))
            ],
          )),
    );
  }
}
