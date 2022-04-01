import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/models/display.dart';
import 'package:soccer_in_your_area/services/firestore_helper.dart';

import '../models/request.dart';

class ScanScreen extends StatelessWidget {
  final Request request;
  DocumentSnapshot? ref;
  ScanScreen({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff193498),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: Display(forCheck: true).infos(request, () {}),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "الطلب",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
