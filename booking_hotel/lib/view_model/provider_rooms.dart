import 'package:flutter/cupertino.dart';

import '../helper/print.dart';
import '../model/room_model.dart';
import '../services/rooms_data.dart';

class ProviderRooms extends ChangeNotifier {
  final List<RoomModel> _rooms = [];

  List<RoomModel> get rooms => _rooms;

  final GetRoomsData listData = GetRoomsData();

  Future<List<RoomModel>> getAllRooms() async {
    printInDebug('get All Rooms.......');
    await listData.getExploreData()?.then((List<RoomModel>? value) async {
      printInDebug('value==> ${value!.length}');
      for (var val in value) {
        _rooms.add(val);
      }
    });
    notifyListeners();
    return _rooms;
  }
}
