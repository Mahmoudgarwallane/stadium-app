import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/widgets/mainbutton_widget.dart';

class NotificationCard extends StatelessWidget {
  final String requestDate;
  final String requestMessage;
  final bool isAccepted;
  final VoidCallback? onPress;
  const NotificationCard({
    this.onPress,
    this.isAccepted = false,
    required this.requestDate,
    required this.requestMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 4, offset: Offset(5, 5)),
          ],
          color: const Color(0xff193498),
          border: Border.all(width: 4, color: Colors.black),
          borderRadius: BorderRadius.circular(34)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  requestDate,
                  style: TextStyle(color: Colors.white54, fontSize: 20),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8, right: 8, left: 8),
            child: Text(
              requestMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          ),
          Visibility(
              visible: isAccepted ? true : false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MainButton(
                    onTap: onPress == null ? () {} : onPress!,
                    child: Text(
                      "QRافتح كود ال ",
                      style: TextStyle(color: Colors.black),
                    )),
              ))
        ],
      ),
    );
  }
}
