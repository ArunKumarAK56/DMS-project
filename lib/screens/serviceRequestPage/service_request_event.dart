import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class ServiceRequestEvent extends BaseEquatable {}

class ServiceRequestInitialEvent extends ServiceRequestEvent {
  BuildContext? context;
  dynamic arguments;

  ServiceRequestInitialEvent({this.context});
}


class GetServiceRequestsEvent extends ServiceRequestEvent {
  GetServiceRequestsEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}