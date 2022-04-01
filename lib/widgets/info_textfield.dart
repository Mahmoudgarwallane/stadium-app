import 'package:flutter/material.dart';

class InfoTextField extends StatelessWidget {
  final String label, hint;
  final TextEditingController? controller;
  final Function(String value) onChanged;
  const InfoTextField({
    this.controller,
    required this.onChanged,
    required this.label,
    required this.hint,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
          TextField(
            controller: controller,
            onChanged: onChanged,
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Color.fromARGB(87, 0, 0, 0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 4),
                    borderRadius: BorderRadius.circular(18)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18))),
          ),
        ],
      ),
    );
  }
}
