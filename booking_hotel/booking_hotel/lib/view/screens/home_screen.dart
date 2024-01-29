import 'package:booking_hotel/const.dart';
import 'package:booking_hotel/helper/print.dart';
import 'package:booking_hotel/size_config.dart';
import 'package:booking_hotel/view/screens/booking_enquiry_screen.dart';
import 'package:booking_hotel/view/screens/create_booking_screen.dart';
import 'package:booking_hotel/view/screens/rooms_screeen.dart';
import 'package:booking_hotel/view/widgets/home_card.dart';
import 'package:booking_hotel/view/widgets/text_form_field.dart';
import 'package:booking_hotel/view_model/provider_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ProviderHome watch = context.watch<ProviderHome>();
    ProviderHome read = context.read<ProviderHome>();
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            /// Rooms Button
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Column(
                        children: const [
                          Text('Admin password'),
                          Divider(),
                        ],
                      ),
                      content: Form(
                          key: _globalKey,
                          child: CustomTextFormFiled(
                            label: 'Password',
                            validator: validator,
                            onChanged: (value) => read.onChangeAdmin(value),
                            onSaved: (value) => read.admin = value,
                          )),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        buildGestureDetector(
                            watch, context, const RoomsScreen()),
                      ],
                    ),
                  );
                },
                child: const HomeCard(
                    text: 'Rooms', color: Colors.lightBlueAccent)),
            const SizedBox(height: 10.0),

            /// Create Booking
            InkWell(
                onTap: () {
                  printInDebug('-------------------');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CreateBookingScreen()));
                },
                child:
                    const HomeCard(text: 'Create book', color: Colors.black26)),
            const SizedBox(height: 10.0),

            /// Book enquiry
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Column(
                        children: const [
                          Text('Admin password'),
                          Divider(),
                        ],
                      ),
                      content: Form(
                          key: _globalKey,
                          child: CustomTextFormFiled(
                            label: 'Password',
                            onChanged: (value) => read.onChangeAdmin(value),
                            onSaved: (value) => watch.admin = value,
                            validator: validator,
                          )),
                      actions: [
                        buildGestureDetector(
                            watch, context, const BookingEnquiryScreen()),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child:
                    const HomeCard(text: 'Book enquiry', color: Colors.brown)),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildGestureDetector(
    ProviderHome watch,
    BuildContext context,
    Widget screen,
  ) {
    return ElevatedButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (!_globalKey.currentState!.validate()) {
          printInDebug('Error---------');
          return;
        } else if (_globalKey.currentState!.validate()) {
          printInDebug('admin: ${watch.admin}');
          // _globalKey.currentState!.save();
          if (watch.admin == admin1) {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => screen,
            ));
          } else {
            printInDebug('----------------------');
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('valid password'),
            ));
          }
        } else {}
      },
      child: const Text(
        'Go',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  validator(val) {
    if (val.isEmpty) {
      return 'valid password';
    } else {
      return _globalKey.currentState!.save();
    }
  }
}
