import 'package:booking_hotel/view_model/provider_booking_enquiry.dart';
import 'package:booking_hotel/view_model/provider_home.dart';
import 'package:booking_hotel/view_model/provider_rooms.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_model/provider_booking.dart';

class Binding {
  static List<SingleChildWidget> multiProvider = <SingleChildWidget>[
    ChangeNotifierProvider<ProviderHome>(create: (_) => ProviderHome()),
    ChangeNotifierProvider<ProviderRooms>(create: (_) => ProviderRooms()),
    ChangeNotifierProvider<ProviderBooking>(create: (_) => ProviderBooking()),
    ChangeNotifierProvider<ProviderBookingEnquiry>(
        create: (_) => ProviderBookingEnquiry()),
  ];
}
