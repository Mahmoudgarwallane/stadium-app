import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/screens/admin_requests_screen.dart';
import 'package:soccer_in_your_area/services/firestore_helper.dart';
import 'package:soccer_in_your_area/widgets/info_textfield.dart';
import 'package:soccer_in_your_area/widgets/mainbutton_widget.dart';

class AdminLoginPage extends StatelessWidget {
  AdminLoginPage({Key? key}) : super(key: key);
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff193498),
        body: SafeArea(
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: Image.asset("images/ball.png")),
                  Container(
                    child: Column(
                      children: [
                        InfoTextField(
                            onChanged: (v) {
                              email = v;
                            },
                            label: "البريد الالكتروني",
                            hint: "أدخل بريدك الإلكتروني"),
                        InfoTextField(
                            onChanged: (v) {
                              password = v;
                            },
                            label: "كلمة السر",
                            hint: "أدخل كلمة السر"),
                      ],
                    ),
                  ),
                  MainButton(
                    onTap: () async {
                      if (email.isNotEmpty && password.isNotEmpty) {
                        print(email);
                        print(password);
                        UserCredential? user = await FirestoreHelper.emailLogin(
                            email.toString().replaceAll(" ", ""),
                            password.toString().replaceAll(" ", ""));
                        if (user != null) {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => AdminRequestScreen()));
                        }
                      }
                    },
                    child: Text(
                      "سجل الدخول",
                      style: TextStyle(fontSize: 27, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
