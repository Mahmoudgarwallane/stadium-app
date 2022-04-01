import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soccer_in_your_area/services/firestore_helper.dart';
import '../models/player.dart';
import '../models/request.dart';
import 'notification_screen.dart';
import '../widgets/info_textfield.dart';
import '../widgets/mainbutton_widget.dart';
import '../widgets/clickable_chip.dart';
import '../widgets/pickers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/route_animations.dart';

class ReservationScreen extends StatefulWidget {
  final String avatarUrl;
  final String userName;
  final GoogleSignIn googleSignIn;
  ReservationScreen({
    required this.avatarUrl,
    required this.userName,
    required this.googleSignIn,
  });
  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String name = "";
  String lastName = "";
  String cardNumber = "";
  DateTime? playingDate;
  TimeOfDay? playingTime;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cardController = TextEditingController();

  int index = 0;

  void clear() {
    nameController.clear();
    lastNameController.clear();
    cardController.clear();
    chips.clear();
    players.clear();
    playingDate = null;
    playingTime = null;
    setState(() {});
  }

  dynamic RemoveOnLongPress(int ind) {
    setState(() {
      chips.removeAt(ind);
      players.removeAt(ind);

      index--;
    });
  }

  addPlayer(String name, String lastName, String card) {
    players.add(Player(name: name, lastName: lastName, cardNumber: card));
  }

  addChip(String name, String lastName) {
    chips.add(ClickableChip(
      isCreator: false,
      index: index,
      onLongPress: RemoveOnLongPress,
      name: name + " " + lastName,
    ));
  }

  addFirstItem() {
    setState(() {
      chips.add(
        ClickableChip(
            isCreator: true,
            index: index,
            onLongPress: (ind) {},
            onTap: (N, L, card) {
              setState(() {
                if (chips.length <= 12) {
                  addChip(N, L);
                  addPlayer(N, L, card);
                }
              });
            }),
      );
    });

    index++;
  }

  List<Widget> chips = [];
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    if (chips.isEmpty) {
      addFirstItem();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff193498),
        appBar: AppBar(
          title: Text(
            "مرحبا ${widget.userName}",
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          actions: [
            IconButton(
                onPressed: () async {
                  await widget.googleSignIn.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(child: Image.network(widget.avatarUrl)),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    InfoTextField(
                      controller: nameController,
                      label: "الاسم",
                      hint: "أدخل اسمك الحقيقي",
                      onChanged: (String value) {
                        name = value;
                      },
                    ),
                    InfoTextField(
                      controller: lastNameController,
                      label: "النسب",
                      hint: "أدخل نسبك",
                      onChanged: (String value) {
                        lastName = value;
                      },
                    ),
                    InfoTextField(
                      controller: cardController,
                      label: "البطاقة الوطنية",
                      hint: "أدخل رقم بطاقة اللاعب ",
                      onChanged: (String value) {
                        cardNumber = value;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: MainButton(
                            onTap: () async {
                              DateTime? _newDate =
                                  await Pickers.datePicker(context);
                              TimeOfDay? _newTime =
                                  await Pickers.timePicker(context);

                              if (_newDate != null && _newTime != null) {
                                playingDate = _newDate;
                                playingTime = _newTime;
                                print(
                                    "${_newDate.day}/${_newDate.month}/${_newDate.year} at ${_newTime.hour}: ${_newTime.minute}");
                                print(
                                    "${playingDate!.day}/${playingDate!.month}/${playingDate!.year} at ${playingTime!.hour}: ${playingTime!.minute}");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "اضغط لإضافة وقت اللعب",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                      ),
                    ),
                    Builder(builder: (context) {
                      print(chips.length);
                      return Wrap(spacing: 3, runSpacing: 0, children: chips);
                    }),
                  ],
                )),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: IconButton(
                      iconSize: 30,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.black,
                      icon: Hero(
                          tag: "bell",
                          child: Image.asset(
                            "images/bell.png",
                            color: Colors.black,
                          )),
                      onPressed: () {
                        Navigator.of(context).push(
                            RouteAnimations.scaleRouteAnimation(
                                widget.googleSignIn.currentUser!));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: MainButton(
                      onTap: () {
                        if (players.isNotEmpty &&
                            name.isNotEmpty &&
                            lastName.isNotEmpty &&
                            cardNumber.isNotEmpty &&
                            (playingDate != null) &&
                            (playingTime != null)) {
                          Request request = Request(
                              adminId: widget.googleSignIn.currentUser!.id,
                              players: players,
                              adminName: name,
                              adminLastName: lastName,
                              CardNumber: cardNumber,
                              startingDate: playingDate!,
                              playingTime: playingTime!);
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              builder: (context) {
                                String summary = "";
                                request.display().forEach((key, value) {
                                  summary += "{$key :  ${value.toString()}} \n";
                                });
                                return SingleChildScrollView(
                                  reverse: true,
                                  child: Column(
                                    children: [
                                      Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Text(
                                                  summary,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 25),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              iconSize: 40,
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                try {
                                                  Navigator.pop(context);
                                                  FirestoreHelper.addRequest(
                                                      request.toMap());
                                                  clear();
                                                } catch (e) {
                                                  print(e.toString());
                                                }
                                              },
                                              iconSize: 40,
                                              icon: Icon(
                                                Icons.send,
                                                color: Colors.blue,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                          print(request.toJson());
                        }
                      },
                      child: const Text(
                        "أرسل طلبا لحجز ملعب",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
