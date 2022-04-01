import 'dart:convert';

class Player {
   final String name;
   final String lastName;
   final String cardNumber;
  Player({
    required this.name,
    required this.lastName,
    required this.cardNumber,
  });
  
    Map<String, dynamic> toDisplay() {
    return {
      'الاسم': name,
      'النسب': lastName,
      'رقم البطاقة': cardNumber,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'cardNumber': cardNumber,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name:  map['name'],
      lastName:  map['lastName'],
      cardNumber:  map['cardNumber']
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source));
}
