import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class SplashEvent extends BaseEquatable {}

class SplashInitialEvent extends SplashEvent {
  BuildContext? context;
  dynamic arguments;
  SplashInitialEvent({this.context});
}