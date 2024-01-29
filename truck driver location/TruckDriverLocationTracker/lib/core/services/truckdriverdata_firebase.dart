
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/truckdriver_model.dart';


class FireStoreTruckDriverUser {
  final CollectionReference _userCollectionReference =
  FirebaseFirestore.instance.collection('TruckDriverUser');

  Future<void> addUserDataToFireStore(TruckDriverModel userDModel) async {
    return await _userCollectionReference
        .doc(userDModel.uid)
        .set(userDModel.toJson());
  }

  Future<void> updateUserDataToFireStore(TruckDriverModel userDModel) async {
    return await _userCollectionReference
        .doc(userDModel.uid)
        .update(userDModel.toJson());
  }
}
