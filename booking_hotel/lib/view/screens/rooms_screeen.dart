import 'package:booking_hotel/model/room_model.dart';
import 'package:booking_hotel/size_config.dart';
import 'package:booking_hotel/view_model/provider_rooms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    context.read<ProviderRooms>().getAllRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderRooms read = context.read<ProviderRooms>();
    ProviderRooms watch = context.watch<ProviderRooms>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rooms'),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () => context.read<ProviderRooms>().getAllRooms(),
          child: watch.rooms.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    final RoomModel room = watch.rooms[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.screenWidth / 10,
                              height: SizeConfig.screenHeight / 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              )),
                          const SizedBox(width: 18.0),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                text('Room number:  ', room.roomNum),
                                text('Hotel branch:  ', room.hotelBranch),
                                text('Room price:  ', '${room.price}'),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),
                          room.statusRoom == 1
                              ? const Text(
                                  'Busy',
                                  style: TextStyle(color: Colors.red),
                                )
                              : const Text(
                                  'available',
                                  style: TextStyle(color: Colors.blue),
                                ),
                        ],
                      ),
                    );
                  },
                  itemCount: watch.rooms.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  RichText text(String label, String text) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 36,
        ),
        children: <TextSpan>[
          TextSpan(text: label),
          TextSpan(
              text: text,
              style: const TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline))
        ],
      ),
      textScaleFactor: 0.5,
    );
  }
}
