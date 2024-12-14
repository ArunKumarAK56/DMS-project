import 'package:bloc/bloc.dart';
import 'package:dms_dealers/base/base_state.dart';
import 'package:dms_dealers/screens/requestSearchFields/workType/work_event.dart';



class WorkTypeBloc extends Bloc<WorkTypeEvent,BaseState> {
  WorkTypeBloc() : super(InitialState());

  // Future<void> fetchWorkType() async {
  //   final dataState = await WorkTypeRepo.getWorkTypeList();
  //
  //   if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
  //     emit(WorkTypeLoadedState(dataState.data!));
  //   }
  //   if (dataState is DataFailed) {
  //     emit(WorkTypeErrorState("Error Fetching Data"));
  //   }
  // }
}
