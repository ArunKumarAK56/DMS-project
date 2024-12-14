

import 'package:flutter/cupertino.dart';

import '../../../utils/base_equatable.dart';

abstract class LocationEvents extends BaseEquatable {}

class LocationEventsStarted extends LocationEvents {
  BuildContext? context;

  LocationEventsStarted({this.context});
}
