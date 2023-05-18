import 'dart:convert';
import 'dart:io';

import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/component/CustomTextFormField.dart';
import '../../common/view/root_tab.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    final storage = ref.read(getSecureStorageProvider);

    const emulatorIP = '10.0.2.2:3000';
    const simulatorIP = '127.0.0.1:3000';

    final ip = Platform.isIOS ? simulatorIP : emulatorIP;
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // 드래그 할 때 키보드 내림
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                    onChanged: (String s) {
                      username = s;
                    },
                    hintText: "이메일을 입력 해주세요."),
                SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                  onChanged: (String s) {
                    password = s;
                  },
                  hintText: "비밀번호를 입력 해주세요.",
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // final rawString = 'test@codefactory.ai:testtest';
                    final rawString = '$username:$password';
                    // print(rawString);

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    var res = await dio.post('http://$ip/auth/login',
                        options: Options(headers: {
                          'authorization':
                              'Basic ${stringToBase64.encode(rawString)}',
                        }));

                    final refreshToken = res.data['refreshToken'];
                    final accessToken = res.data['accessToken'];

                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: accessToken);
                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => RootTab()));
                    // print(res.data);
                  },
                  child: Text("로그인"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                ),
                TextButton(
                  onPressed: () {
                    print("");
                  },
                  child: Text("회원가입"),
                  style: TextButton.styleFrom(foregroundColor: PRIMARY_COLOR),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "환영합니다!",
      style: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인해주세요!. \n아직 회원이 아니신가요? 회원가입을 해주세요",
      style: TextStyle(
        fontSize: 16.0,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
