import 'package:dms_dealers/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'location_events.dart';


class LocationBloc extends Bloc<LocationEvents, BaseState> {
  LocationBloc() : super(InitialState());

  // Future<void> fetchLocation() async {
  //   final dataState = await LocationRepo.getLocations();
  //   if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
  //     emit(LocationLoadedState(dataState.data!));
  //   }
  //   if (dataState is DataFailed) {
  //     emit(LocationErrorState("Error Fetching Data"));
  //   }
  // }
}
