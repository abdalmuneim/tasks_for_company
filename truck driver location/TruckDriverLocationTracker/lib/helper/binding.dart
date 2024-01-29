import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/provider/auth_provider.dart';
import '../core/provider/get_add_shipments_provider.dart';
import '../core/provider/track_location_provider.dart';

class Binding {
  final List<SingleChildWidget> _binding = <SingleChildWidget>[
    // Authentication Provider
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),

    // Get and Add Shipments Provider
    ChangeNotifierProvider(create: (context) => ShipmentProvider()),

    // Create Track on a Map
    ChangeNotifierProvider(create: (context) => TrackLocationProvider()),
  ];

  List<SingleChildWidget> get binding => _binding;
}
