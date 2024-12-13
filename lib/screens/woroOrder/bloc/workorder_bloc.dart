import 'package:dio/dio.dart';
import 'package:dms_dealers/base/base_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'workorder_event.dart';

class WorkorderBloc extends Bloc<WorkorderEvent, BaseState> {
  WorkorderBloc(super.initialState);
//   final GetWorkOrderUsecase _getWorkOrderUsecase;
//
//   WorkorderBloc(this._getWorkOrderUsecase) : super(const WorkorderLoading()) {
//     on<GetWorkOrderEvent>(onGetWorkOrders);
//     on<GetFavouriteEvent>(onGetFavourite);
//     on<WorkOrderStatusUpDateEvent>(upDateWorkOrderStatus);
//   }
// /////////////////////////// GET WORK ORDER EVENT HANDLER \\\\\\\\\\\\\\\\\\\\\\\\\\
//   void onGetWorkOrders(
//       GetWorkOrderEvent event, Emitter<BaseState> emit) async {
//     final dataState = await _getWorkOrderUsecase();
//
//     if (dataState is SuccessState && dataState.data!.isNotEmpty) {
//       emit(WorkorderLoaded(dataState.data!));
//     }
//
//     if (dataState is FailureState) {
//       emit(WorkorderError(dataState.error!));
//     }
//   }
//
//   void onGetFavourite(
//       GetFavouriteEvent event, Emitter<BaseState> emit) async {
//     final dataState = await _getWorkOrderUsecase();
//
//     if (dataState is SuccessState && dataState.data!.isNotEmpty) {
//       emit(WorkorderLoaded(dataState.data!));
//     }
//
//     if (dataState is FailureState) {
//       emit(WorkorderError(dataState.error!));
//     }
//   }
//
// /////////////////////////// UPDATE WORK ORDER STATUS EVENT HANDLER \\\\\\\\\\\\\\\\\\\\\\\\\\
//   void upDateWorkOrderStatus(
//       WorkorderEvent event, Emitter<WorkorderState> emit) async {
//     if (event is WorkOrderStatusUpDateEvent) {
//       try {
//         await WorkOrderStatusUpdateApi.updateWorkOrderStatus(
//             event.workOrderId, event.status);
//         emit(WorkOrderStatusUpdateSuccess());
//
//         final dataState = await _getWorkOrderUsecase();
//
//         if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
//           emit(WorkorderLoaded(dataState.data!));
//         }
//
//         if (dataState is DataFailed) {
//           emit(WorkorderError(dataState.error!));
//         }
//       } catch (e) {
//         throw Exception(e.toString());
//       }
//     }
//   }
}
