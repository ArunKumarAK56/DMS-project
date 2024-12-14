import 'package:dms_dealers/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'asset_event.dart';
import 'domain/asset_repo.dart';

class AssetBloc extends Bloc<AssetEvent,BaseState> {
  AssetBloc() : super(InitialState());

  // Future<void> fetchAssets() async {
  //   final dataState = await AssetRepo.getAssets();
  //   if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
  //     emit(AssetsLoadedState(dataState.data!));
  //   }
  //   if (dataState is DataFailed) {
  //     emit(AssetsErrorState("Error Fetching Data"));
  //   }
  // }
}
