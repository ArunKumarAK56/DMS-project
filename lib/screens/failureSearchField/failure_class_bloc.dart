import 'package:dms_dealers/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'failure_drop_down_event.dart';


class FailureClassBloc extends Bloc<FailureDropDownEvent,BaseState>{
  FailureClassBloc() : super(InitialState());

  // Future<void> fetchFailureClass() async {
  //   final dataState = await FailureClassRepo.getFailureClass();
  //
  //   if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
  //     emit(FailureClassLoadedState(dataState.data!));
  //   }
  //   if (dataState is DataFailed) {
  //     emit(FailureClassErrorState("Error Fetching Data"));
  //   }
  // }
}
