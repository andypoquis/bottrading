import 'package:bottrading/app/data/models/devices.dart';
import 'package:bottrading/app/data/services/firestoreDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:binance_spot/binance_spot.dart';

class BotController extends GetxController {
  RxDouble lastClosePrice = (0.0).obs;
  var klineStreamSub;
  //variables BINANCE

  RxString stateMarket = ''.obs;

  RxDouble minValue = (39473.31 * 0.985).obs;
  RxDouble maxValue = (41011.40 * 1.01).obs;

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
    key: "2x3tr62pm9758LUpiC1JeSKH3Nowxb3ajeM8XbOwNXeBJC7IOkMgGOIa6VDfEUHb",
    secret: "mls2UDYEfzoVNEmcz8IUvzu8xsEJRnCDEIM49cSO8Qwo6bjUlj7DZ6VZMsiljdhj",
  );

  void startKlineStream() {
    var stream = binanceSpot.klineStream(
      symbol: "BTCBUSD",
      interval: Interval.INTERVAL_1M,
    );
    klineStreamSub = stream.listen(handleNewKline);
  }

  void handleNewKline(WsKlineEvent event) {
    lastClosePrice.value = event.kline.close;

    if (devices[1].isInit == false && lastClosePrice.value != 0.0) {
      FirestoreDB.updateIsInit(true, devices[1].id);
      buyOrderInit();
    }
    {
      if (devices[1].isBuy == false) {
        if (lastClosePrice.value <= devices[1].valueCripto! &&
            (lastClosePrice.value <= maxValue.value)) {
          buyOrder();
        }
      } else {
        if (lastClosePrice.value >= devices[1].valueCripto! &&
            (lastClosePrice.value >= minValue.value)) {
          sellOrder();
        }
      }
    }
  }

  buyOrder() {
    stateMarket.value = 'COMPRADO';
    // valueCripto.value = lastClosePrice.value * 1.003;
    // cantCripto.value = (devices[0].capital! / lastClosePrice.value) * 0.999;
    // isBuy(true);
    double price = lastClosePrice.value;
    FirestoreDB.updateValueBuy((devices[1].capital! / price) * 0.999,
        price * 1.003, true, devices[1].id);
  }

  buyOrderInit() {
    stateMarket.value = 'COMPRADO';
    double price = lastClosePrice.value;
    FirestoreDB.updateValueBuy((devices[1].capital! / price) * 0.999,
        price * 1.003, true, devices[1].id);

    FirestoreDB.updateInitBot2(true, price * 0.998, devices[0].id);
  }

  sellOrder() {
    stateMarket.value = 'VENDIDO';
    // capital.value = (devices[0].cantCripto! * lastClosePrice.value) * 0.999;
    // valueCripto.value = lastClosePrice.value * 0.992;
    // isBuy(false);
    double price = lastClosePrice.value;
    FirestoreDB.updateValueSell((devices[1].cantCripto! * price) * 0.999,
        price * 0.995, false, devices[1].id);
  }

  void startTradeStream() async {
    var response = await binanceSpot.newOrder(
        symbol: 'MANABUSD', side: Side.BUY, type: OrderType.MARKET);
  }
}
