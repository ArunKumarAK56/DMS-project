import 'package:flutter/cupertino.dart';

import '../../../utils/base_equatable.dart';

abstract class WorkTypeEvent extends BaseEquatable {}

class WorkTypeInitialEvent extends WorkTypeEvent {
  BuildContext? context;
  dynamic arguments;

  WorkTypeInitialEvent({this.context});
}