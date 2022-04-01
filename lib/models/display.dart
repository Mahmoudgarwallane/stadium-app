import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/models/request.dart';

import '../widgets/mainbutton_widget.dart';

class Display {
  final bool? forCheck;
  Display({this.forCheck = false});
  List<Widget> info = [];
  List<String> weekdays = [
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت",
    "الأحَد",
  ];
  TextStyle infostyle = const TextStyle(fontSize: 25, color: Colors.white);
  TextStyle infoboldstyle = const TextStyle(
      fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold);
  List<Widget> infos(Request userRequest, VoidCallback onPress) {
    info = [
      Text(
        "الاسم",
        textAlign: TextAlign.center,
        style: infoboldstyle,
      ),
      Text(
        userRequest.adminName,
        textAlign: TextAlign.center,
        style: infostyle,
      ),
      Text(
        "النسب",
        style: infoboldstyle,
        textAlign: TextAlign.center,
      ),
      Text(
        userRequest.adminLastName,
        style: infostyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "رقم البطاقة الوطنية",
        style: infoboldstyle,
        textAlign: TextAlign.center,
      ),
      Text(
        userRequest.CardNumber.toString(),
        style: infostyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "يوم بداية اللعب",
        style: infoboldstyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "${userRequest.startingDate.day}/${userRequest.startingDate.month}/${userRequest.startingDate.year}",
        style: infostyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "ساعة اللعب",
        style: infoboldstyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "${userRequest.playingTime.minute} : ${userRequest.playingTime.hour}",
        style: infostyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "يوم اللعب",
        style: infoboldstyle,
        textAlign: TextAlign.center,
      ),
      //! heeeeeeeeere
      Text(
        weekdays[userRequest.startingDate.weekday - 1],
        style: infostyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "ساعة انتهاء اللعب",
        style: infoboldstyle,
        textAlign: TextAlign.center,
      ),
      Text(
        "${userRequest.Endtime.minute} : ${userRequest.Endtime.hour}",
        style: infostyle,
        textAlign: TextAlign.center,
      ),
      const Text(
        "الفريق",
        style: TextStyle(
            fontSize: 40,
            color: Color.fromARGB(255, 0, 174, 255),
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ];
    userRequest.players.forEach((element) {
      info.add(
        Text(
          "الاسم",
          textAlign: TextAlign.center,
          style: infoboldstyle,
        ),
      );
      info.add(
        Text(
          element.name,
          textAlign: TextAlign.center,
          style: infostyle,
        ),
      );

      info.add(
        Text(
          "النسب",
          textAlign: TextAlign.center,
          style: infoboldstyle,
        ),
      );
      info.add(
        Text(
          element.lastName,
          textAlign: TextAlign.center,
          style: infostyle,
        ),
      );
      info.add(
        Text(
          "رقم البطاقة الوطنية",
          textAlign: TextAlign.center,
          style: infoboldstyle,
        ),
      );
      info.add(
        Text(
          element.cardNumber.toString(),
          textAlign: TextAlign.center,
          style: infostyle,
        ),
      );
    });
    if (forCheck == false) {
      info.add(MainButton(
        onTap: onPress,
        child: Text(
          "قبول الطلب",
          style: TextStyle(fontSize: 27, color: Colors.black),
        ),
      ));
    }

    return info;
  }
}
