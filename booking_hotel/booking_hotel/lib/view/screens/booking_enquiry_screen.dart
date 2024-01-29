import 'package:booking_hotel/size_config.dart';
import 'package:booking_hotel/view/widgets/text_form_field.dart';
import 'package:booking_hotel/view_model/provider_booking_enquiry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingEnquiryScreen extends StatefulWidget {
  const BookingEnquiryScreen({Key? key}) : super(key: key);

  @override
  State<BookingEnquiryScreen> createState() => _BookingEnquiryScreenState();
}

class _BookingEnquiryScreenState extends State<BookingEnquiryScreen> {
  @override
  Widget build(BuildContext context) {
    final ProviderBookingEnquiry read = context.read<ProviderBookingEnquiry>();
    final ProviderBookingEnquiry watch =
        context.watch<ProviderBookingEnquiry>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book enquiry'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Search by ID'),
                    ),
                    onSaved: (value) => read.id = value,
                    onChanged: (value) => read.onIDChang(value, context),
                  ),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                    onPressed: () => read.getAllBooks(),
                    child: const Text('Get All'))
              ],
            ),
          ),

          /// Display Data
          Container(
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 60.0, bottom: 5.5),
            child: watch.booking.isNotEmpty
                ? ListView(
                    children: watch.booking
                        .map((e) => Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ID:    ${e.id}'),
                                  Text('Name:    ${e.guestName}'),
                                  Text('Guest Number:    ${e.guestNum}'),
                                  Text('Hotel Branch:    ${e.hotelBranch}'),
                                  Text('Rooms Number:    ${e.roomNum}'),
                                  Text('Booked Suit?    ${e.suit}'),
                                  Text('Total Price:    ${e.totalPrice}'),
                                  Text('Booking Days Number:    ${e.daysNum}'),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ))
                        .toList(),
                  )
                : const Center(
                    child: Text(
                    'No Book yet',
                    style: TextStyle(fontSize: 30, color: Colors.blue),
                    textAlign: TextAlign.center,
                  )),
          ),
        ],
      ),
    );
  }
}
