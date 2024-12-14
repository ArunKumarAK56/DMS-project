
import 'package:dms_dealers/screens/drawer/WorkOrderPage/workorder_repo.dart';
import 'package:dms_dealers/screens/drawer/WorkOrderPage/workorders.dart';
import 'package:rxdart/rxdart.dart';

class WorkOrderBloc {

  WorkOrderBloc() {
    getData();
  }

  final _subject = BehaviorSubject<List<WorkOrder>>();

  Stream<List<WorkOrder>> get stream => _subject.stream;

  Function(List<WorkOrder>) get _update => _subject.sink.add;

  getData() async {
    _update(await WorkOrderRepo.getWorkorderList());
  }

  dispose() {
    _subject.close();
  }
}
