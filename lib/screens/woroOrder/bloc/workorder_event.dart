part of 'workorder_bloc.dart';

@immutable
abstract class WorkorderEvent {
  const WorkorderEvent();
}

class GetWorkOrderEvent extends WorkorderEvent {
  const GetWorkOrderEvent();
}

class GetFavouriteEvent extends WorkorderEvent {
  const GetFavouriteEvent();
}

class WorkOrderStatusUpDateEvent extends WorkorderEvent {
  final String workOrderId;
  final String status;

  const WorkOrderStatusUpDateEvent({required this.workOrderId, required this.status});
}

class WorkOrderEventInitialEvent extends WorkorderEvent {
  BuildContext? context;
  dynamic arguments;

  WorkOrderEventInitialEvent({this.context});

}

class WorkOrderFilteredEvent extends WorkorderEvent {}
