// To parse this JSON data, do
//
//     final accountInformation = accountInformationFromJson(jsonString);

import 'dart:convert';

AccountInformation accountInformationFromJson(String str) =>
    AccountInformation.fromJson(json.decode(str));

String accountInformationToJson(AccountInformation data) =>
    json.encode(data.toJson());

class AccountInformation {
  AccountInformation({
    this.makerCommission,
    this.takerCommission,
    this.buyerCommission,
    this.sellerCommission,
    this.canTrade,
    this.canWithdraw,
    this.canDeposit,
    this.updateTime,
    this.accountType,
    this.balances,
    this.permissions,
  });

  int? makerCommission;
  int? takerCommission;
  int? buyerCommission;
  int? sellerCommission;
  bool? canTrade;
  bool? canWithdraw;
  bool? canDeposit;
  int? updateTime;
  String? accountType;
  List<Balance>? balances;
  List<String>? permissions;

  factory AccountInformation.fromJson(Map<String, dynamic> json) =>
      AccountInformation(
        makerCommission: json["makerCommission"],
        takerCommission: json["takerCommission"],
        buyerCommission: json["buyerCommission"],
        sellerCommission: json["sellerCommission"],
        canTrade: json["canTrade"],
        canWithdraw: json["canWithdraw"],
        canDeposit: json["canDeposit"],
        updateTime: json["updateTime"],
        accountType: json["accountType"],
        balances: List<Balance>.from(
            json["balances"].map((x) => Balance.fromJson(x))),
        permissions: List<String>.from(json["permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "makerCommission": makerCommission,
        "takerCommission": takerCommission,
        "buyerCommission": buyerCommission,
        "sellerCommission": sellerCommission,
        "canTrade": canTrade,
        "canWithdraw": canWithdraw,
        "canDeposit": canDeposit,
        "updateTime": updateTime,
        "accountType": accountType,
        "balances": List<dynamic>.from(balances!.map((x) => x.toJson())),
        "permissions": List<dynamic>.from(permissions!.map((x) => x)),
      };
}

class Balance {
  Balance({
    this.asset,
    this.free,
    this.locked,
  });

  String? asset;
  String? free;
  String? locked;

  factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        asset: json["asset"],
        free: json["free"],
        locked: json["locked"],
      );

  Map<String, dynamic> toJson() => {
        "asset": asset,
        "free": free,
        "locked": locked,
      };
}
