import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soccer_in_your_area/screens/admin_user_info_screen.dart';
import 'package:soccer_in_your_area/screens/qr_screen.dart';
import 'package:soccer_in_your_area/widgets/admin_request_card.dart';
import '../models/request.dart';
import '../widgets/notification_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // here we get user snapshots
  static requestSnapchots(GoogleSignInAccount user) => _firestore
      .collection("requests")
      .where("requestId", isEqualTo: user.id)
      .orderBy('ts', descending: true)
      .snapshots();
  static final adminRequestSnapchots = _firestore
      .collection("requests")
      .orderBy('ts', descending: true)
      .snapshots();

  // here we add request
  static addRequest(Map<String, dynamic> request) {
    _firestore.collection('requests').add(request);
  }

  // here we login with email and password
  static Future<UserCredential?> emailLogin(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("error !!!");
      print(e);
      return null;
    }
  }

  // here we get request through snapshot
  static Widget getRequests(AsyncSnapshot snapshot, BuildContext context) {
    if (snapshot.hasData) {
      final data = snapshot.data?.docs;
      List<NotificationCard> requestWidgets = [];
      data?.forEach((element) {
        Request request =
            Request.fromMap(element.data() as Map<String, dynamic>);
        DateTime date = request.creationTime!.toDate();
        if (request.isAccepted) {
          requestWidgets.add(NotificationCard(
            onPress: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return QrScreen(qrData: element.id.toString());
              }));
            },
            isAccepted: true,
            requestDate:
                "${date.year.toString()}/${date.month.toString()}/${date.day.toString()}",
            requestMessage: "تمت الموافقة على طلبك  ",
          ));
        } else {
          requestWidgets.add(NotificationCard(
            requestDate:
                "${date.year.toString()}/${date.month.toString()}/${date.day.toString()}",
            requestMessage:
                "تم إرسال طلبك بنجاح المرجو الانتظار حتى تتم الموافقة عليه",
          ));
        }
      });
      return ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        children: requestWidgets,
      );
    }
    return const Text("");
  }

  static Widget getAdminRequests(AsyncSnapshot snapshot, BuildContext context) {
    if (snapshot.hasData) {
      final data = snapshot.data?.docs;
      List<AdminRequestCard> requestWidgets = [];
      data?.forEach((element) {
        Request request =
            Request.fromMap(element.data() as Map<String, dynamic>);
        DateTime date = request.creationTime!.toDate();
        if (request.isAccepted) {
          requestWidgets.add(AdminRequestCard(
            onPress: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return AdminUserInfoScreen(
                  onPress: () {},
                  userRequest: request,
                );
              }));
            },
            isAccepted: true,
            requestDate:
                "${date.year.toString()}/${date.month.toString()}/${date.day.toString()}",
            requestMessage: "طلب من ${request.adminName}",
          ));
        } else {
          requestWidgets.add(AdminRequestCard(
            onPress: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
                return AdminUserInfoScreen(
                  onPress: () {
                    FirebaseFirestore.instance
                        .collection("requests")
                        .doc(element.id)
                        .update({"isAccepted": true});
                  },
                  userRequest: request,
                );
              }));
            },
            requestDate:
                "${date.year.toString()}/${date.month.toString()}/${date.day.toString()}",
            requestMessage: "طلب من ${request.adminName}",
          ));
        }
      });
      return Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          shrinkWrap: true,
          children: requestWidgets,
        ),
      );
    }
    return const Text("");
  }
}
