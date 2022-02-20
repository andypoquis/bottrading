import 'package:binance_spot/binance_spot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../data/models/devices.dart';
import '../data/services/firestoreDB.dart';

class Bot2Controller extends GetxController {
  RxDouble lastClosePrice = (0.0).obs;
  var klineStreamSub;
  //variables BINANCE
  RxDouble capitalInitial = (100.0).obs; //Initial capital
  RxDouble capital = (100.0).obs; //Variable capital
  RxDouble cantCripto = (0.0).obs; //Amount Cripto
  RxBool isBuy = false.obs;
  RxBool isInit = false.obs;
  RxDouble valueCripto = (0.0).obs;
  RxString stateMarket = ''.obs;

  RxDouble minValue = (1.043 * 0.985).obs;
  RxDouble maxValue = (0.992 * 1.01).obs;

  //User
  RxDouble balanceUser = (0.0).obs;

  //FireStore Data
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Rx<List<Devices>> devicesList = Rx<List<Devices>>([]);
  List<Devices> get devices => devicesList.value;

  @override
  void onInit() {
    startKlineStream();
    super.onInit();
    devicesList.bindStream(FirestoreDB.deviceStream());
  }

  BinanceSpot binanceSpot = BinanceSpot(
    key: "Hh5mNRmdt2Ob6IQW86ByEu43ZBJXB62WOjswl2hGeAVxnzu36Tu0xAKRynceSzJX",
    secret: "KmriS129focQRHwwJH1bN6fgt8ooZrE7YfegKZvj5rFVV4ceUqqeUAmBtoWLb2mn",
  );

  void startKlineStream() {
    var stream = binanceSpot.klineStream(
        symbol: "MANABUSD", interval: Interval.INTERVAL_1m);
    klineStreamSub = stream.listen(handleNewKline);
  }

  void handleNewKline(WsKlineEvent event) {
    lastClosePrice.value = event.kline.close;

    if (devices[0].isInit == false && lastClosePrice.value != 0.0) {
      isInit.value = true;
      FirestoreDB.updateIsInit(true, devices[0].id);
      buyOrder();
    }
    {
      if (devices[0].isBuy == false) {
        if (lastClosePrice.value <= devices[0].valueCripto! &&
            (lastClosePrice.value <= maxValue.value)) {
          buyOrder();
        }
      } else {
        if (lastClosePrice.value >= devices[0].valueCripto! &&
            (lastClosePrice.value >= minValue.value)) {
          sellOrder();
        }
      }
    }
  }

  buyOrder() {
    stateMarket.value = 'COMPRADO';
    FirestoreDB.updateValueBuy(
        (devices[0].capital! / lastClosePrice.value) * 0.999,
        lastClosePrice.value * 1.003,
        true,
        devices[0].id);
  }

  sellOrder() {
    stateMarket.value = 'VENDIDO';
    FirestoreDB.updateValueSell(
        (devices[0].cantCripto! * lastClosePrice.value) * 0.999,
        lastClosePrice.value * 0.998,
        false,
        devices[0].id);
  }

  void startTradeStream() async {
    var response = await binanceSpot.newOrder(
        symbol: 'MANABUSD', side: Side.BUY, type: OrderType.MARKET);
  }
}
