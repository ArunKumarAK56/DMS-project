import 'package:dms_dealers/base/base_state.dart';
import 'package:dms_dealers/screens/drawer/WorkOrderPage/work_order_page_calendar.dart';
import 'package:dms_dealers/screens/drawer/WorkOrderPage/workorder_bloc.dart';
import 'package:dms_dealers/screens/drawer/WorkOrderPage/workorders.dart';
import 'package:dms_dealers/screens/drawer/drawer_bloc.dart';
import 'package:dms_dealers/screens/drawer/model/workorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../homeBottom/workorder_update_api.dart';
import '../../woroOrder/bloc/workorder_bloc.dart';
import '../../woroOrder/model/workorder.dart';
import '../widgets/app_bar.dart';

/////////////////////////////////////////////////////////////
/// WORK ORDER PAGE
/////////////////////////////////////////////////////////////

/// This page is from Dashboard
class WorkOrderPage extends StatefulWidget {
  /// Receiving workorders from [DASHBOARD PAGE]
  final List<Result> workOrders;
  final String title;
  final Color? color;

  const WorkOrderPage({
    super.key,
    required this.workOrders,
    required this.title,
    this.color,
  });

  @override
  State<WorkOrderPage> createState() => _DashboardWorkOrdersPageState();
}

/////////////////////////// STATE \\\\\\\\\\\\\\\\\\\\\\\\\\

class _DashboardWorkOrdersPageState extends State<WorkOrderPage> {
  String selectedOptions = "Option 1";
  bool isSelected = true;

  /// Helper variables for Bookmark functionality
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  bool? isSelectedData =  false;
  List<String> sortOptions = [
    "My Work",
    "Due Date",
    "Open",
    "All Status",
    "Priority"
  ];

  // Define selected categories as a ValueNotifier
  final selectedCategories = ValueNotifier<Set<String>>({});

  /// Local variable for getting and showing filtered workorders.
  List<Result> _foundWorkOrder = [];
  final TextEditingController _searchController = TextEditingController();


  // Define a library object with categories
  final library = Library(
    categories: ['Category 1', 'Category 2', 'Category 3', 'Category 4'],
  );

  List<CheckBoxListTileModel> checkBoxListTileModel =
  CheckBoxListTileModel.getUsers();

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
    });
  }

  @override
  void initState() {
    _foundWorkOrder = widget.workOrders;
    super.initState();
  }

  /// Function used for search functionality
  void _searchWorkOrder(String enteredKeyword) {
    List<Result> results;

    if (enteredKeyword.isEmpty) {
      results = widget.workOrders; // Ensure workOrders is non-null
    } else {
      results = widget.workOrders.where(
            (element) =>
        (element.workOrderName?.toLowerCase().contains(enteredKeyword.toLowerCase()) ?? false) &&
            (element.code?.toLowerCase().contains(enteredKeyword.toLowerCase()) ?? false),
      ).toList();
    }

    setState(() {
      _foundWorkOrder = results; // Ensure _foundWorkOrder is initialized
    });
  }


  void _clearSearch() {
    _searchController.clear();
    _searchWorkOrder(''); // Trigger search to reset results
  }

  @override
  void dispose() {
    super.dispose();
  }

  /////////////////////////// BUILD METHOD \\\\\\\\\\\\\\\\\\\\\\\\\\

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(210),
        child: Material(
          elevation: 4,
          child: Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                OAppBar(
                  title: "Work order" ,
                  leadingIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                        ),
                        onPressed: () {
                          // context.go("/home");
                          Navigator.pop(context);
                        },
                      ),
                      // const Text(
                      //   'Back',
                      //   style: TextStyle(
                      //     color: Colors.blue,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ],
                  ),
                  icon: Icons.calendar_today_outlined,
                  onPress: () {


                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const WorkOrderCalendarPage(),
                        ));

                  },
                ),

                /////////////////////////// SEARCH FIELD \\\\\\\\\\\\\\\\\\\\\\\\\\
                // const SearchField(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _searchWorkOrder(value),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      hintText: "search by", // Ensure this is defined
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      suffixIcon: _searchController.text.isNotEmpty // Check controller text
                          ? IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: _clearSearch,
                        color: Colors.grey.shade400,
                      )
                          : null,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                /* ------------------ 2_Filters Section ------------------ */
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 4,
                //     bottom: 4,
                //     left: 8,
                //     right: 0,
                //   ),
                //   child: Filterchips(
                //       label: Text(context.local.choose),
                //       sortOptions: sortOptions,
                //       selectedCategories: selectedCategories,
                //       library: library),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                /* ------------------ Sort By Section ------------------ */

                SortBySection(
                  checkBoxListTileModel: checkBoxListTileModel,
                  workOrders: widget.workOrders,
                ),
                // const SizedBox(height: 5),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: widget.color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
                // const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),

      /////////////////////////// BODY  \\\\\\\\\\\\\\\\\\\\\\\\\\

      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            widget.workOrders.isNotEmpty
                ?
            /* ------------------ Work Order List Section------------------ */
            Expanded(
              child: ListView.separated(
                  itemCount: _foundWorkOrder.length,
                  // The list items
                  itemBuilder: (context, index) {
                    var workOrder = _foundWorkOrder[index];
                    String? priority;
                    if (workOrder.priorityName != null) {
                      priority = workOrder.priorityName!.toString()
                          .startsWith("N")
                          ? workOrder.priorityName?.toString().substring(0, 7)
                          : workOrder.priorityName?.toString().substring(0, 10);
                    } else {
                      priority = "";
                    }

                    selectedItem[index] =
                        workOrder.isFavouriteWo ?? false;

                    print("${workOrder.isFavouriteWo}");

                    isSelectedData =  selectedItem[index];

                    return SizedBox(
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              /* ------------------ Status ------------------ */
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green[400]!,
                                      Colors.green[600]!
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  workOrder.status.toString() ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  /* ------------------ Work Tile ------------------ */
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context)
                                        .width *
                                        0.5,
                                    child: Text(
                                      workOrder.workOrderName ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Aeon',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  /* ------------------ WO No. Priority ------------------ */
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "#${workOrder.code?.trim()}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Aeon',
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        priority == ""
                                            ? ""
                                            : priority!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Aeon',
                                            color: priority ==
                                                "Emergency "
                                                ? Colors.red[600]
                                                : Colors.blue[600]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey[300]),
                              const SizedBox(height: 8),

                              /* ------------------ Other Details - First Line ------------------ */
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.grey[600]),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${workOrder.locationCode ?? ""} - ${workOrder.locationName ?? ""}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Aeon',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              /* ------------------ Other Details - Second Line ------------------ */

                              Row(
                                children: [
                                  Icon(Icons.business_center,
                                      color: Colors.grey[600]),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${workOrder.assetCode ?? ""} - ${workOrder.assetName ?? ""}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Aeon',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              /* ------------------ Other Details - Third Line ------------------ */

                              Row(
                                children: [
                                  Icon(Icons.person,
                                      color: Colors.grey[600]),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Me',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Aeon',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          // Toggle the selected item state
                                          selectedItem[index] = !isSelectedData!;

                                          isSelectedData = !isSelectedData!;
                                          _foundWorkOrder[index].isFavouriteWo = !_foundWorkOrder[index].isFavouriteWo!;
                                        });

                                        // Determine if any item is selected
                                        isSelectItem = selectedItem.containsValue(true);


                                        print("isSelectItem${_foundWorkOrder[index].isFavouriteWo!}");

                                        try {
                                          // Call the API to save the work order status update
                                          await WorkOrderStatusUpdateApi.saveWorkOrder(
                                            workOrder.id!,
                                            _foundWorkOrder[index].isFavouriteWo!,  // Pass the toggled state
                                            workOrder.assetId!,
                                          );

                                          // After successful API call, update the state to reflect the change
                                        } catch (error) {
                                          // Handle API errors here
                                          print('Error saving work order status: $error');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.all(12), // Background color
                                      ),
                                      child: Icon(
                                        size: isSelectedData! ? 21 : 18,
                                        isSelectedData! ? Icons.bookmark_added : Icons.bookmark_add,
                                        color: isSelectedData! ? Colors.green : Colors.grey.shade400,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         WorkorderDetailsPage(
                                        //             workOrder: state
                                        //                 .workOrders![
                                        //             index]),
                                        //   ),
                                        // );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.all(
                                            12), // Background color
                                      ),
                                      child: const Icon(
                                          Icons.more_vert,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    );
                  },
                  // The separators
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 3,
                      color: Colors.grey.shade300,
                    );
                  }),
            )
                : const Center(
              child: Text("No WorkOrders Available"),
            )
          ],
        ),
      ),
    );
  }
}

/* ----------------------------------------------------------------- */
/*   )))))))))))))>> WIDGETS OF WORK ORDER PAGE  <<((((((((((((( */
/* ----------------------------------------------------------------- */

/* ------------------ SORT BY SECTION ------------------ */

class SortBySection extends StatelessWidget {
  final List<Result> workOrders;

  const SortBySection({
    super.key,
    required this.checkBoxListTileModel,
    required this.workOrders,
  });

  final List<CheckBoxListTileModel> checkBoxListTileModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // BOTTOM SHEET
                  // buildShowModalBottomSheet(context);
                },
                child: const Icon(Icons.sort_outlined),
              ),
              const SizedBox(
                width: 5,
              ),
              Text("status")
            ],
          ),
          Text(" ${workOrders.length} Results"),
          // StreamBuilder(
          //     stream: _bloc.stream,
          //     builder: (context, snapshot) {
          //       List<WorkOrder>? workOrders = snapshot.data;
          //       if (!snapshot.hasData) {
          //         return const Align(
          //             alignment: Alignment.topCenter, child: CupertinoActivityIndicator());
          //       } else {
          //         return Text(" ${workOrders?.length} Results");
          //       }
          //     })
        ],
      ),
    );
  }

  ///////////////////////////  \\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 3,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  Text(
                    "sort by",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  /* ------------------ List View ------------------ */

                  Expanded(
                    child: ListView.separated(
                        itemCount: checkBoxListTileModel.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 35,
                            child: Center(
                              child: ListTile(
                                titleAlignment: ListTileTitleAlignment.center,
                                title: Text(
                                  checkBoxListTileModel[index].title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      // fontWeight:
                                      //     FontWeight
                                      //         .w600,
                                      letterSpacing: 0.5),
                                ),
                                trailing: checkBoxListTileModel[index].isCheck
                                    ? const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                                    : null,
                                selectedColor: Colors.blue,
                                onTap: () {},
                                onLongPress: () {},
                              ),
                            ),
                            // CheckboxListTile(
                            //     activeColor: Colors.pink[300],
                            //     dense: true,
                            //     //font change
                            //     title:  Text(
                            //       checkBoxListTileModel[index].title,
                            //       style: const TextStyle(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w600,
                            //           letterSpacing: 0.5),
                            //     ),
                            //     value: checkBoxListTileModel[index].isCheck,
                            //
                            //     onChanged: (bool? val) => itemChange(val!, index)),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

/* ------------------ SEARCH FIELD ------------------ */

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            isDense: true,
            // Added this
            contentPadding: const EdgeInsets.all(8),
            hintText:"search by",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: const Icon(
              Icons.search,
              size: 30,
            ),
            prefixIconColor: Colors.grey.shade400),
      ),
    );
  }
}

/* ------------------ FILTER CHIPS ------------------ */

class Filterchips extends StatelessWidget {
  const Filterchips(
      {Key? key,
        this.isNeedDropdown = false,
        required this.sortOptions,
        required this.selectedCategories,
        required this.library,
        this.label})
      : super(key: key);
  final bool isNeedDropdown;
  final List<String> sortOptions;
  final ValueNotifier<Set<String>> selectedCategories;
  final Library library;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      // width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade200,
            child: IconButton(
              icon: const Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          const Visibility(
            visible: false,
            child: Positioned(
              // draw a red marble
              top: 0.0,
              right: 5.0,
              child:
              Icon(Icons.brightness_1, size: 10.0, color: Colors.redAccent),
            ),
          ),
          const VerticalDivider(
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: sortOptions.length,
              itemBuilder: (BuildContext context, int index) {
                /* ------------------ Filter  Chips ------------------ */

                // return Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: isNeedDropdown
                //         ? FilterChipWithDropDown<String>(
                //       label: Text(
                //         selectedCategories.value.isEmpty
                //             ? 'Category'
                //             : selectedCategories.value.first,
                //       ),
                //       value: selectedCategories.value.isEmpty
                //           ? null
                //           : selectedCategories.value.first,
                //       items: [
                //         const DropdownMenuItem(
                //             value: null, child: Text('all')),
                //         for (final category in library.categories)
                //           DropdownMenuItem(
                //               value: category, child: Text(category)),
                //       ],
                //       onChanged: (category) {
                //         selectedCategories.value = {
                //           if (category != null) category
                //         };
                //       },
                //     )
                //         : FilterChipWithOutDropdown(
                //         label: Text(sortOptions[index])));
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* ------------------ OTHER HELPERS ------------------ */

class Library {
  final List<String> categories;

  Library({required this.categories});
}

class CheckBoxListTileModel {
  String title;
  bool isCheck;

  CheckBoxListTileModel({required this.title, required this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(title: "Due Date", isCheck: false),
      CheckBoxListTileModel(title: "Asset", isCheck: false),
      CheckBoxListTileModel(title: "Status", isCheck: true),
      CheckBoxListTileModel(title: "Location", isCheck: false),
    ];
  }
}

class StreamBuilderWidget extends StatefulWidget {
  const StreamBuilderWidget({super.key});

  @override
  State<StreamBuilderWidget> createState() => _StreamBuilderWidgetState();
}

class _StreamBuilderWidgetState extends State<StreamBuilderWidget> {
  final WorkOrderBloc _bloc = WorkOrderBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Result> workOrders = snapshot.data;
            return Text("${workOrders[0].assetName}");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
