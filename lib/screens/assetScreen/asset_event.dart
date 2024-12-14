import 'package:flutter/cupertino.dart';

import '../../utils/base_equatable.dart';

abstract class AssetEvent extends BaseEquatable {}

class AssetInitialEvent extends AssetEvent {
  BuildContext? context;
  dynamic arguments;

  AssetInitialEvent({this.context});
}


class GetAssetEvent extends AssetEvent {
  GetAssetEvent({this.context, this.arguments});
  BuildContext? context;
  dynamic arguments;
}