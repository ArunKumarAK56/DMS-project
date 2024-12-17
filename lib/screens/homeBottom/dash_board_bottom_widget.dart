import 'package:dms_dealers/screens/drawer/WorkOrderPage/work_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import '../../utils/contants.dart';
import '../drawer/drawer_bloc.dart';
import '../drawer/drawer_event.dart';
import '../drawer/model/favoriteWorkOrder.dart';
import '../drawer/model/workorder.dart';
import '../woroOrder/model/workorder.dart';

/// Displays List view of work orders counts by status
class DashBoardBottomWidget extends StatefulWidget {
  const DashBoardBottomWidget({super.key});

  @override
  State<DashBoardBottomWidget> createState() => _DashBoardBottomWidgetState();
}

class _DashBoardBottomWidgetState extends State<DashBoardBottomWidget> {
  List<dynamic> favoriteWorkOrders = [];
  bool isLoading = false;
  String errorMessage = '';
  late DrawerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DrawerBloc>(context);
    bloc.add(GetWorkOrderEvent(context: context));
    bloc.add(GetFavoriteEvent(context: context));
  }

  Map<String, int?> statusMap = {
    "All Pending": 0,
    "Open": 0,
    "In Progress": 0,
    "Stop": 0,
    "Past Due": 0,
    "Due Today": 0,
    "Completed": 0
  };

  Map<int, List<Result>?> newStatusMap = {
    0: [],
    1: [],
    2: [],
    3: [],
    4: [],
    5: [],
    6: [],
  };

  late List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.teal,
    Colors.green,
  ];

  late List<IconData?> icons = [
    Icons.pending_actions,
    Icons.task_alt,
    Icons.play_arrow,
    Icons.pause,
    Icons.access_time,
    Icons.today,
    Icons.done,
  ];

  @override
  Widget build(BuildContext context) {
    List<int?> counts = statusMap.values.toList();
    var titles = statusMap.entries.toList();

    return BlocListener<DrawerBloc, BaseState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is SuccessState) {
          if (state.successResponse is WorkOrder) {
            final WorkOrder response = state.successResponse;

            if (response.statusCode == Constants.successCode) {
              setState(() {
                var results = response.result?.toList() ?? [];

                var newItems = results.where((e) => e.status.name == "NEW").toList();
                var allPending = results.where((e) => e.status.name != "COMP").toList();
                var inProgressItems = results.where((e) => e.status.name == "INPRG").toList();
                var stopItems = results.where((e) => e.status.name == "STP").toList();
                var completedItems = results.where((e) => e.status.name == "COMP").toList();

                newStatusMap[0] = allPending;
                statusMap["All Pending"] = allPending.length;

                newStatusMap[1] = newItems;
                statusMap["Open"] = newItems.length;

                newStatusMap[2] = inProgressItems;
                statusMap["In Progress"] = inProgressItems.length;

                newStatusMap[3] = stopItems;
                statusMap["Stop"] = stopItems.length;

                newStatusMap[6] = completedItems;
                statusMap["Completed"] = completedItems.length;

                counts = statusMap.values.toList();
                titles = statusMap.entries.toList();
              });
            }
          } else if(state.successResponse is FavoriteWorkOrder){
            final FavoriteWorkOrder response = state.successResponse;
            if (response.statusCode == Constants.successCode) {
              setState(() {
                favoriteWorkOrders = response.result?.toList() ?? [];
              });

            }
          }
        }
      },
      child: BlocBuilder<DrawerBloc, BaseState>(
        bloc: bloc,
        builder: (context, state) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {},
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.black26),
                      ),
                      child: ListTile(
                        minLeadingWidth: 5,
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          height: 30,
                          width: 5,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              favoriteWorkOrders.length.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                          ],
                        ),
                        title: const Text("Saved"),
                        onTap: () {},
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return WorkOrderPage(
                                        workOrders: newStatusMap[index] ?? [],
                                        title: titles[index].key,
                                        color: colors[index]);
                                  }));

                            },
                            child: ProjectCard(
                              title: titles[index].key,
                              count: counts[index]?.toString() ?? "0",
                              color: colors[index],
                              icon: icons[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final IconData? icon;

  const ProjectCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 30,
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Aeon',
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Aeon',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
