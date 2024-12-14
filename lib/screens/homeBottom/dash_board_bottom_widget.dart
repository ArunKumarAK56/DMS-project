import 'package:dms_dealers/screens/homeBottom/workorder_update_api.dart';
import 'package:flutter/material.dart';

import '../../utils/extensions/constants.dart';
import '../drawer/WorkOrderPage/work_order_page.dart';
import '../woroOrder/model/workorder.dart';


/////////////////////////////////////////////////////////////
/// DASHBOARD BOTTOM WIDGET
/////////////////////////////////////////////////////////////

/// Displays List view of work orders counts by status
class DashBoardBottomWidget extends StatefulWidget {
  const DashBoardBottomWidget({
    super.key,
  });

  @override
  State<DashBoardBottomWidget> createState() => _DashBoardBottomWidgetState();
}

class _DashBoardBottomWidgetState extends State<DashBoardBottomWidget> {

  List<dynamic> favoriteWorkOrders = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchFavoriteWorkOrders();
  }

  Future<void> _fetchFavoriteWorkOrders() async {
    setState(() {
      isLoading = true;
    });
    try {
      final favoriteWorkOrderss = await WorkOrderStatusUpdateApi.getFavorite();

      print("favoriteWorkOrders${favoriteWorkOrders}");
      // Assuming the message contains the list of favorite work orders
      setState(() {
        favoriteWorkOrders = favoriteWorkOrderss ?? [];
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }
/////////////////////////// BUILD METHOD \\\\\\\\\\\\\\\\\\\\\\\\\\
  @override
  Widget build(BuildContext context) {
    // Used to Display status counts.
    /// STATUS MAP: All WorkOrder Statuses with 0 initial count value.
    Map<String, int?> statusMap = {
      "All Pending": 0,
      "Open": 0,
      "In Progress": 0,
      "Stop": 0,
      "Past Due": 0,
      "Due Today": 0,
      "Completed": 0
    };
    //  Used for filtering work orders by status
    Map<int, List<WorkorderEntity>?> newStatusMap = {
      0: [],
      1: [],
      2: [],
      3: [],
      4: [],
      5: [],
      6: [],
    };

    /// TITLES :
    var titles = statusMap.entries.toList();
    bool refresh = false;

    return Expanded(
      child: RefreshIndicator(
        // onRefresh: () async {
        //   await _bloc.fetchServiceRequest();
        // },
        onRefresh: () async {},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Colors.black26,
                  ),
                ),
                borderOnForeground: false,
                child: ListTile(
                  minLeadingWidth: 5,
                  leading: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      ),
                    ],
                  ),
                  title: const Text("Saved"),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return DashboardFavWorkOrdersPage(
                    //       workOrders: favoriteWorkOrders ?? [],
                    //       title: "Favourite WorkOrders"
                    //   ); }));
                  },
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 16, // spacing between rows
                    crossAxisSpacing: 16, // spacing between columns
                  ),
                  padding: const EdgeInsets.all(8.0), // padding around the grid
                  itemCount: titles.length, // total number of items
                  itemBuilder: (BuildContext context, int index) {
                    List<int?> counts = statusMap.values.toList();
                    return InkWell(
                      onTap: () {
                        WorkOrderPage(
                            workOrders: newStatusMap[index] ?? [],
                            title: titles[index].key,
                            color: colors[index]);
                      },
                      child: ProjectCard(
                        title: titles[index].key,
                        count: counts[index].toString(),
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
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final IconData? icon;

  const ProjectCard(
      {super.key,
        required this.title,
        required this.count,
        required this.color,
        this.icon});

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
