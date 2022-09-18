
import 'package:flutter/cupertino.dart';

import '../helper/print.dart';

class ProviderHome extends ChangeNotifier {

  String? admin;

  onChangeAdmin(value) {
    printInDebug(value);
    notifyListeners();
    return admin = value;
  }

}
