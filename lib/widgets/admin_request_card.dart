import 'package:flutter/material.dart';

class AdminRequestCard extends StatelessWidget {
  final String requestDate;
  final String requestMessage;
  final bool isAccepted;
  final VoidCallback onPress;
  const AdminRequestCard({
    required this.onPress,
    this.isAccepted = false,
    required this.requestDate,
    required this.requestMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPress ,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54, blurRadius: 4, offset: Offset(5, 5)),
            ],
            color: Colors.white,
            border: Border.all(width: 4, color: Colors.black),
            borderRadius: BorderRadius.circular(34)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        requestDate,
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: isAccepted
                      ? const Icon(
                          Icons.check,
                          size: 35,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.question_mark,
                          size: 30,
                          color: Colors.red,
                        ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8, right: 8, left: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  requestMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
              ),
            ),
            Visibility(
                visible: isAccepted ? true : false,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: null,
                ))
          ],
        ),
      ),
    );
  }
}
