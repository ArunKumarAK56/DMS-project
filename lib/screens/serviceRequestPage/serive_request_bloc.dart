import 'dart:convert';

import 'package:dms_dealers/base/base_state.dart';
import 'package:dms_dealers/screens/serviceRequestPage/service_request_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../http/api_repository.dart';
import '../../http/httpurls.dart';
import '../../utils/contants.dart';
import '../login_page/model/LoginResponseModel.dart';


class ServiceRequestBloc extends  Bloc<ServiceRequestEvent, BaseState> {
  ServiceRequestBloc() : super(InitialState());

  @override
  Stream<BaseState> mapEventToState(ServiceRequestEvent event,) async* {
    if (event is InitialState) {
      yield LoadingState();
      yield SuccessState(successResponse: 'success');
    } else if (event is GetServiceRequestsEvent) {
      dynamic response;
      yield LoadingState();
      print(event.arguments);
      final dynamic returnableValues = await APIRepository().dynamicRequest(
          HttpUrl.loginUrl,
          userArguments: jsonEncode(event.arguments),
          method: ApiRequestMethod.post,
          isBearerTokenNeed: false,
          context: event.context);

      if(returnableValues!=null){
        print("checklogger ${returnableValues}");
        response = Login.fromJson(returnableValues);
        yield SuccessState(successResponse: response);
      }else{
        print("checklogger error ${returnableValues}");
        yield FailureState(errorMessage: response);
      }
    }
  }
}
