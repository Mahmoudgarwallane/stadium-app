import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'player.dart';

class Request {
  final bool isAccepted;
  final List<Player> players;
  final String adminName;
  final String adminLastName;
  final String CardNumber;
  final DateTime startingDate;
  final TimeOfDay playingTime;
  final TimeOfDay Endtime;
  final String adminId;
  final Timestamp? timeStamp;
  final Timestamp? creationTime;

  Request({
    this.isAccepted = false,
    this.creationTime,
    required this.adminId,
    required this.players,
    required this.adminName,
    required this.adminLastName,
    required this.CardNumber,
    required this.startingDate,
    required this.playingTime,
  })  : Endtime =
            TimeOfDay(hour: playingTime.hour + 1, minute: playingTime.minute),
        timeStamp = Timestamp.now();

  Map<String, dynamic> toMap() {
    print(timeStamp.toString());
    return {
      'ts': timeStamp,
      'isAccepted': isAccepted,
      'requestId': adminId,
      'players': players.map((x) => x.toMap()).toList(),
      'adminName': adminName,
      'adminLastName': adminLastName,
      'CardNumber': CardNumber,
      'startingYear': startingDate.year,
      'startingMonth': startingDate.month,
      'startingDay': startingDate.day,
      'playingHour': playingTime.hour,
      'playingMinute': playingTime.minute,
      'endHour': Endtime.hour,
      'endMinute': Endtime.minute
    };
  }

  Map<String, dynamic> display() {
    return {
      'الفريق': players.map((x) => x.toDisplay()).toList(),
      'اسم المشرف': adminName,
      'نسب المشرف': adminLastName,
      'البطاقة الوطنية': CardNumber,
      'يوم اللعب': startingDate.day,
      'ساعة اللعب': playingTime.hour,
      'دقيقة اللعب': playingTime.minute,
      'ساعة انتهاء اللعب': Endtime.hour,
      'دقيقة انتهاء اللعب': Endtime.minute
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      creationTime: map['ts'],
      isAccepted: map['isAccepted'],
      adminId: map['requestId'],
      players: List<Player>.from(map['players']?.map((x) => Player.fromMap(x))),
      adminName: map['adminName'] ?? '',
      adminLastName: map['adminLastName'] ?? '',
      CardNumber: map['CardNumber'] ?? '',
      startingDate: DateTime(
          map["startingYear"], map["startingMonth"], map["startingDay"]),
      playingTime:
          TimeOfDay(hour: map["playingHour"], minute: map["playingMinute"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) =>
      Request.fromMap(json.decode(source));
}
