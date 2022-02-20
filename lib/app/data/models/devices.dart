import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Devices devicesFromJson(String str) => Devices.fromJson(json.decode(str));

String devicesToJson(Devices data) => json.encode(data.toJson());

class Devices {
  Devices({
    this.cantCripto,
    this.capital,
    this.isBuy,
    this.valueCripto,
    this.isInit,
  });
  String? id;
  double? cantCripto;
  double? capital;
  bool? isBuy;
  double? valueCripto;
  bool? isInit;

  factory Devices.fromJson(Map<String, dynamic> json) => Devices(
        cantCripto: json["cantCripto"],
        capital: json["capital"],
        isBuy: json["isBuy"],
        valueCripto: json["ValueCripto"],
        isInit: json["isInit"],
      );

  Map<String, dynamic> toJson() => {
        "cantCripto": cantCripto,
        "capital": capital,
        "isBuy": isBuy,
        "ValueCripto": valueCripto,
        "isInit": isInit,
      };

  Devices.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    cantCripto = documentSnapshot["cantCripto"].toDouble();
    capital = documentSnapshot["capital"].toDouble();
    isBuy = documentSnapshot["isBuy"];
    valueCripto = documentSnapshot["valueCripto"].toDouble();
    isInit = documentSnapshot["isInit"];
  }
}
