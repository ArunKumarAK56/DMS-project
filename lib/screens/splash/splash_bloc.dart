import 'package:bloc/bloc.dart';
import 'package:dms_dealers/screens/splash/splash_event.dart';

import '../../base/base_state.dart';

class SplashBloc extends Bloc<SplashEvent, BaseState> {
  SplashBloc() : super(InitialState());
  @override
  Stream<BaseState> mapEventToState(
      SplashEvent event,
      ) async* {
    if (event is SplashInitialEvent) {
      yield ScreenLoadState();
    }
  }
}