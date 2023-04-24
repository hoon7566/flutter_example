import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

import '../../common/component/CustomTextFormField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,// 드래그 할 때 키보드 내림
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
                    onChanged: (String s) {}, hintText: "이메일을 입력 해주세요."),
                SizedBox(height: 20.0,),
                CustomTextFormField(
                  onChanged: (String s) {},
                  hintText: "비밀번호를 입력 해주세요.",
                  obscureText: true,
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(onPressed: (){print("");}, child: Text("로그인"), style: ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),),
                TextButton(onPressed: (){print("");}, child: Text("회원가입") , style: TextButton.styleFrom(foregroundColor: PRIMARY_COLOR),)
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
