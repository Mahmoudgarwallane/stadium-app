import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../models/request.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/firestore_helper.dart';

class NotificationScreen extends StatelessWidget {
  GoogleSignInAccount user;
  NotificationScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    decoration: const BoxDecoration(
                        color: Color(0xff113CFC),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100),
                            bottomRight: Radius.circular(100))),
                    child: Hero(
                      tag: "bell",
                      child: Image.asset(
                        "images/bell.png",
                        width: 50,
                      ),
                    )),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirestoreHelper.requestSnapchots(user),
                        builder: (context, snapshot) {
                          return FirestoreHelper.getRequests(snapshot, context);
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
