import 'package:flutter/material.dart';

class Pickers {
  static Future<DateTime?> datePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
        locale: const Locale("fr", "FR"),
        builder: (context, child) {
          return Theme(
            child: child!,
            data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                    primary: Color(0xff1597E5),
                    onPrimary: Color.fromARGB(255, 255, 255, 255),
                    surface: Color(0xff193498),
                    onSurface: Color.fromARGB(255, 255, 255, 255),
                    onBackground: Color.fromARGB(255, 0, 0, 0))),
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month + 1, DateTime.now().day));
    return date;
  }

  static Future<TimeOfDay?> timePicker(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
              child: child!,
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xff1597E5),
                  onPrimary: Color.fromARGB(255, 255, 255, 255),
                  surface: Color(0xff193498),
                  onSurface: Color.fromARGB(255, 255, 255, 255),
                  onBackground: Color.fromARGB(255, 0, 0, 0),
                ),
                dialogBackgroundColor: Colors.black,
              ));
        },
        context: context);
    return time;
  }
}
