import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

import '../../helper/print.dart';
import '../../size_config.dart';
import '../../view_model/provider_booking.dart';
import '../widgets/text_form_field.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({Key? key}) : super(key: key);

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  @override
  void initState() {
    context.read<ProviderBooking>().getAvailableRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderBooking watch = context.watch<ProviderBooking>();
    ProviderBooking read = context.read<ProviderBooking>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        centerTitle: true,
        elevation: 0,
      ),
      body: watch.roomsAvailable.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _globalKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomTextFormFiled(
                                boardType: TextInputType.text,
                                label: 'Guest Name',
                                onSaved: (val) => read.guestName = val,
                                onChanged: (val) => read.onGuestNameChange(val),
                                validator: validator,
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth / 3,
                              child: CustomTextFormFiled(
                                boardType: TextInputType.number,
                                label: 'ID',
                                hint: '123',
                                onSaved: (val) => read.id = val,
                                onChanged: (val) => read.onIDChange(val),
                                validator: validator,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          /// DropdownButton Hotel Branches
                          DropdownButton<String>(
                            value: watch.onHotelBranchChange,
                            onChanged: (value) =>
                                read.onHotelBranchChange = value,
                            hint: const Text('Hotel branch'),
                            items: watch.items
                                .map<DropdownMenuItem<String>>(
                                    (val) => DropdownMenuItem<String>(
                                          value: val,
                                          child: Text(val),
                                        ))
                                .toList(),
                          ),
                          const SizedBox(width: 10),

                          /// Guests Number
                          Expanded(
                            child: CustomTextFormFiled(
                              label: ' Guests number',
                              boardType: TextInputType.number,
                              onSaved: (val) => read.guestNum = val,
                              onChanged: (val) => read.onGuestNuMChange(val),
                              validator: validator,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// DropdownButton rooms in hotel branch
                      DropDownMultiSelect(
                        onChanged: (List<String> x) {
                          read.onRoomsChange = x;
                        },
                        options: watch.roomsNum,
                        selectedValues: read.onRoomsChange,
                        whenEmpty: 'Select Rooms',
                      ),
                      const SizedBox(height: 20),

                      /// Choose Suite
                      CheckboxListTile(
                        value: watch.suite,
                        onChanged: (value) => read.onSuitChang(value),
                        title: const Text('Do you need suite?'),
                      ),
                      const SizedBox(height: 20),

                      /// Date Time Start and End
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () =>
                                _selectStartDate(context, read, watch),
                            child: Text(read.getStartDateText()),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: SizeConfig.screenWidth / 2,
                            child: CustomTextFormFiled(
                              boardType: TextInputType.number,
                              label: 'how many days?',
                              onSaved: (val) => read.daysNum = val,
                              onChanged: (val) => read.selectDaysNumber(val),
                              validator: validator,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// discounted price (95%) if the customer has booked previously in the hotel
                      CheckboxListTile(
                        value: watch.haveBooked,
                        onChanged: (value) => read.onHaveBookedChang(value!),
                        title: const Text(
                            'Do you have booked previously in the hotel?'),
                      ),
                      const SizedBox(height: 20),

                      /// Total Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Price'),
                          Text(watch.totalPrice.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (!_globalKey.currentState!.validate()) {
                              printInDebug('Error---------');
                              return;
                            } else if (_globalKey.currentState!.validate()) {
                              printInDebug('----------------------');
                              Navigator.of(context).pop();
                              await read.createBooking(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Something wrong...'),
                              ));
                            }
                          },
                          child: const Text('Book'))
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> _selectStartDate(
      BuildContext context, ProviderBooking read, ProviderBooking watch) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != watch.startDate) {
      read.selectedStartDate(picked);
    }
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  validator(val) {
    if (val.isEmpty) {
      return 'required';
    } else {
      return _globalKey.currentState!.save();
    }
  }
}
