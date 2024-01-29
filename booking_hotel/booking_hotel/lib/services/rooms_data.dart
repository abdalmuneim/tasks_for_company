import 'dart:convert';
import 'package:booking_hotel/helper/print.dart';
import 'package:booking_hotel/model/room_model.dart';
import 'package:flutter/services.dart';

class GetRoomsData {
  Future<List<RoomModel>?>? getExploreData() async {
    final RoomsModel? getListData = await _getData();
    return getListData?.rooms;
  }

  Future<RoomsModel?> _getData() async {
    try {
      final dataString = await _loadAsset('assets/rooms.json');
       printInDebug("roomsString: $dataString");
      final json = jsonDecode(dataString);
      if (json['rooms'] != null) {
        final RoomsModel data = RoomsModel.fromJson(json);
        printInDebug("json: $data");
        return data;
      } else {
         printInDebug('hase been some error');
      }
    } catch (e) {
      printInDebug('error => $e');
    }
    return null;
  }

  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
