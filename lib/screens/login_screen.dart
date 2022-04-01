import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/screens/admin_login_page.dart';
import 'reserve_screen.dart';
import '../widgets/mainbutton_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              iconSize: 50,
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => AdminLoginPage()));
              },
              icon: Icon(Icons.admin_panel_settings))),
      backgroundColor: Color(0xff113CFC),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(child: Image.asset("images/player.png")),
              const Text(
                "احجز ملعبا بطريقة أفضل",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              MainButton(
                onTap: () async {
                  try {
                    GoogleSignInAccount? account = await _googleSignIn.signIn();
                    GoogleSignInAuthentication googleAuth =
                        await account!.authentication;
                    AuthCredential credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    print('done');
                  } catch (e) {
                    print(e.toString());
                  }
                  if (_googleSignIn.currentUser != null) {
                    _user = _googleSignIn.currentUser;
                    print("here");
                    Navigator.of(context).push(PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 1000),
                      transitionsBuilder:
                          (context, animation, anotherAnimation, child) {
                        animation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.fastLinearToSlowEaseIn,
                            reverseCurve: Curves.fastOutSlowIn);
                        return SlideTransition(
                            position: Tween(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset(0.0, 0.0))
                                .animate(animation),
                            child: child);
                      },
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ReservationScreen(
                          avatarUrl: _user!.photoUrl!,
                          userName: _user!.displayName!,
                          googleSignIn: _googleSignIn,
                        );
                      },
                    ));
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "سجل الدخول",
                        style: TextStyle(fontSize: 27, color: Colors.black),
                      ),
                    ),
                    Image.asset("images/google.png"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
