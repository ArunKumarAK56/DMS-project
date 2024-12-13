


import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class HomeEvent extends BaseEquatable {}

class HomeInitialEvent extends HomeEvent {
  BuildContext? context;
  dynamic arguments;
  HomeInitialEvent({this.context});
}

class ProfileDetailsApiEvent extends HomeEvent {
  ProfileDetailsApiEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}

class GetUserVehicleEvent extends HomeEvent {
  GetUserVehicleEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}