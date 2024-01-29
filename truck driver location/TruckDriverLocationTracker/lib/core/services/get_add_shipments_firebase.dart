import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/shipment_model.dart';

class GetAndAddShipmentsFirebase {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('StartShipment');

  Future<void> addShipmentFirebase(ShipmentModels shipmentModels) async {
    return await _userCollectionReference
        .doc(shipmentModels.uid)
        .collection(shipmentModels.driver)
        .doc(shipmentModels.timestamp)
        .set(shipmentModels.toJson());
  }
  Future<void> updateShipmentFirebase(ShipmentModels shipmentModels) async {
    return await _userCollectionReference
        .doc(shipmentModels.uid)
        .collection(shipmentModels.driver)
        .doc(shipmentModels.timestamp)
        .update(shipmentModels.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getShipmentsFirebase(
      uid, driver) {
    return _userCollectionReference
        .doc(uid)
        .collection(driver)
        .orderBy("timestamp", descending: true)
        .limit(20)
        .snapshots();
  }
}
