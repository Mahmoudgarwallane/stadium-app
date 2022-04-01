import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/models/display.dart';
import 'package:soccer_in_your_area/models/request.dart';
import 'package:soccer_in_your_area/widgets/mainbutton_widget.dart';

class AdminUserInfoScreen extends StatelessWidget {
  final Request userRequest;
  final VoidCallback onPress;
  const AdminUserInfoScreen(
      {required this.userRequest, required this.onPress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xff193498),
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: const Text("الطلبات"),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.all(20),
            children: Display().infos(userRequest, onPress),
          ),
        ));
  }
}
