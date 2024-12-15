
import 'package:flutter/cupertino.dart';

import '../../../utils/base_equatable.dart';


abstract class FailureDropDownEvent extends BaseEquatable {}

class AppStarted extends FailureDropDownEvent {
  BuildContext? context;

  AppStarted({this.context});
}
