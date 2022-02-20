import 'package:bottrading/app/data/models/devices.dart';
import 'package:bottrading/app/data/provider/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
  static addDevice(Devices devices) async {
    await firebaseFirestore.collection('devices').add({});
  }

  static Stream<List<Devices>> deviceStream() {
    return firebaseFirestore
        .collection('devices')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Devices> devices = [];
      for (var device in query.docs) {
        final devicesModel =
            Devices.fromDocumentSnapshot(documentSnapshot: device);
        devices.add(devicesModel);
      }
      return devices;
    });
  }

  static updateValueBuy(double cantCripto, double valueCripo, bool isBuy, id) {
    firebaseFirestore.collection('devices').doc(id).update({
      'cantCripto': cantCripto.toDouble(),
      'valueCripto': valueCripo.toDouble(),
      'isBuy': isBuy
    });
  }

  static updateValueSell(double capital, double valueCripo, bool isBuy, id) {
    firebaseFirestore.collection('devices').doc(id).update({
      'capital': capital.toDouble(),
      'valueCripto': valueCripo.toDouble(),
      'isBuy': isBuy
    });
  }

  static updateIsInit(bool isInit, id) {
    firebaseFirestore.collection('devices').doc(id).update({'isInit': isInit});
  }

  static updateInitBot2(bool isInit, double valueCripo, id) {
    firebaseFirestore
        .collection('devices')
        .doc(id)
        .update({'valueCripto': valueCripo.toDouble(), 'isInit': isInit});
  }
}
