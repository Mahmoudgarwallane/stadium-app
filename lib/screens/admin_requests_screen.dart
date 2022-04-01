import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:soccer_in_your_area/screens/scan_screen.dart';
import 'package:soccer_in_your_area/services/firestore_helper.dart';

import '../models/request.dart';

class AdminRequestScreen extends StatelessWidget {
  const AdminRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff193498),
        appBar: AppBar(
          actions: [
            IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                iconSize: 30,
                onPressed: () async {
                  try {
                    String barcodeScanRes =
                        await FlutterBarcodeScanner.scanBarcode(
                            "#ff6666", "Cancel", false, ScanMode.QR);
                    DocumentSnapshot ref = await FirebaseFirestore.instance
                        .collection("requests")
                        .doc(barcodeScanRes)
                        .get();
                    final Request request =
                        Request.fromMap(ref.data() as Map<String, dynamic>);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => ScanScreen(
                                  request: request,
                                )));
                  } catch (e) {
                    print("error");
                  }
                },
                icon: Icon(Icons.qr_code_scanner))
          ],
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "الطلبات",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamBuilder(
            stream: FirestoreHelper.adminRequestSnapchots,
            builder: (context, snapshot) {
              return FirestoreHelper.getAdminRequests(snapshot, context);
            }),
      ),
    );
  }
}
