


import 'package:bloc/bloc.dart';
import 'package:dms_dealers/screens/homeScreen/home_event.dart';

import '../../base/base_state.dart';
import '../drawer/drawer_event.dart';

class HomeBloc extends Bloc<HomeEvent, BaseState> {
  HomeBloc() : super(InitialState());
  @override
  Stream<BaseState> mapEventToState(
      HomeEvent event,
      ) async* {
    if (event is HomeInitialEvent) {
      yield ScreenLoadState();
    }
  }
}
