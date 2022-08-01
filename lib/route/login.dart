import 'package:FGithub/Const.dart';
import 'package:FGithub/net/Github.dart';
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
  final GlobalKey _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Github github = Github(context);
    return Scaffold(
      backgroundColor: AppConst.themeColor.shade50,
      body: const Center(
          //TODO 等换成新图标
          child: FlutterLogo(
        size: 100,
      )),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
              16,
              0,
              16,
              //软键盘遮挡
              MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //输入用户名和token
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        validator: (v) {
                          return v!.trim().isNotEmpty ? null : "用户名不能为空";
                        },
                        decoration: const InputDecoration(
                            labelText: "用户名", prefixIcon: Icon(Icons.person)),
                      ),
                      TextFormField(
                        controller: _tokenController,
                        validator: (v) {
                          return v!.trim().isNotEmpty ? null : "Token不能为空";
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: "Token",
                            prefixIcon: Icon(Icons.vpn_key)),
                      ),
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: MaterialButton(
                  onPressed: () {
                    if ((_formKey.currentState as FormState).validate()) {
                      github
                          .login(
                              _userNameController.text, _tokenController.text)
                          .then((value) {
                        if (value != null) {
                          SmartDialog.showToast("登陆成功",
                              time: const Duration(seconds: 2));
                          Navigator.popAndPushNamed(context, "main");
                        } else {
                          SmartDialog.showToast("账号或Token错误");
                        }
                      }, onError: (error, stackTrace) {
                        SmartDialog.showToast("登陆错误，请重试");
                      });
                    }
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Padding(
                      padding: EdgeInsets.all(12), child: Text("开始登陆")),
                ),
              ),
              //登陆按钮
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
