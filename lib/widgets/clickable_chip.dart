import 'package:flutter/material.dart';
import 'info_textfield.dart';
import 'mainbutton_widget.dart';

class ClickableChip extends StatelessWidget {
  final int index;
  final String? name;
  String playerName = "";
  String playerLastName = "";
  String playerCard = "";
  final bool isCreator;
  void Function(String first, String last,String card)? onTap;
  final Function(int index) onLongPress;

  ClickableChip({
    required this.isCreator,
    required this.index,
    this.name,
    required this.onLongPress,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        onLongPress(index);
        print(index);
      },
      child: Chip(
        backgroundColor: Colors.white,
        avatar: !isCreator
            ? CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 17,
                  color: Colors.white,
                ))
            : null,
        deleteIcon: const CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        onDeleted: isCreator
            ? () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  InfoTextField(
                                    label: "الاسم",
                                    hint: "أدخل اسم اللاعب",
                                    onChanged: (String value) {
                                      playerName = value;
                                    },
                                  ),
                                  InfoTextField(
                                    label: "النسب",
                                    hint: "أدخل نسب الاعب",
                                    onChanged: (String value) {
                                      playerLastName = value;
                                    },
                                  ),
                                  InfoTextField(
                                    label: "البطاقة الوطنية",
                                    hint: "أدخل رقم بطاقة اللاعب ",
                                    onChanged: (String value) {
                                      playerCard = value;
                                    },
                                  ),
                                  MainButton(
                                      onTap: onTap != null
                                          ? () {
                                              if (playerName.isNotEmpty &&
                                                  playerLastName.isNotEmpty &&
                                                  playerCard.isNotEmpty) {
                                                onTap!(
                                                    playerName, playerLastName,playerCard);
                                                Navigator.pop(context);
                                              }
                                            }
                                          : () {},
                                      child: Text(
                                        "أضف",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ))
                                ],
                              ),
                            ),
                          ));
                    });
              }
            : null,
        label: Text(name == null ? "أضف أسماء فريقك" : name!),
      ),
    );
  }
}
