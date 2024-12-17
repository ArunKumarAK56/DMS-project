
import 'dart:convert';

import 'package:dms_dealers/screens/drawer/drawer_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import '../../http/api_repository.dart';
import '../../http/httpurls.dart';
import '../../utils/contants.dart';
import 'model/favoriteWorkOrder.dart';
import 'model/workorder.dart';


class DrawerBloc extends Bloc<DrawerEvent, BaseState> {
  DrawerBloc() : super(InitialState());

  @override
  Stream<BaseState> mapEventToState(
      DrawerEvent event,
      ) async* {
    if (event is DrawerInitialEvent) {
      yield LoadingState();
      yield SuccessState(successResponse: 'success');
    } else if (event is GetWorkOrderEvent) {
      dynamic response;
      yield LoadingState();
      final dynamic returnableValues = await APIRepository().dynamicRequest(
          HttpUrl.workOrder,
          userArguments: jsonEncode(event.arguments),
          method: ApiRequestMethod.get,
          isBearerTokenNeed: true,
          context: event.context);

      if(returnableValues!=null){
        print("checklogger ${returnableValues}");
        response = WorkOrder.fromJson(returnableValues);
        yield SuccessState(successResponse: response);
      }else{
        print("checklogger error ${returnableValues}");
        yield FailureState(errorMessage: response);
      }
    }else if (event is GetFavoriteEvent) {
      dynamic response;
      yield LoadingState();
      final dynamic returnableValues = await APIRepository().dynamicRequest(
          HttpUrl.getFavorite,
          userArguments: jsonEncode(event.arguments),
          method: ApiRequestMethod.get,
          isBearerTokenNeed: true,
          context: event.context);

      if(returnableValues!=null){
        print("checklogger ${returnableValues}");
        response = FavoriteWorkOrder.fromJson(returnableValues);
        yield SuccessState(successResponse: response);
      }else{
        print("checklogger error ${returnableValues}");
        yield FailureState(errorMessage: response);
      }
    }
  }

}
