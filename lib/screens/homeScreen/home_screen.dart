import 'package:dms_dealers/http/httpurls.dart';
import 'package:dms_dealers/screens/drawer/drawer_bloc.dart';
import 'package:dms_dealers/screens/homeScreen/home_bloc.dart';
import 'package:dms_dealers/screens/morePage/more_page_screen.dart';
import 'package:dms_dealers/screens/woroOrder/bloc/workorder_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import '../../utils/color_resources.dart';
import '../drawer/drawer_screen.dart';
import '../drawer/drawer_event.dart';
import '../serviceRequestPage/serive_request_bloc.dart';
import '../serviceRequestPage/service_request_event.dart';
import '../serviceRequestPage/service_request_page.dart';
import '../url_page/urlpage_bloc.dart';
import '../url_page/urlpage_event.dart';
import '../woroOrder/work_order.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  final String results;

  const HomeScreen({super.key, this.index = 0, this.results = ''});

  @override
  State<HomeScreen> createState() => _DmsDrawerState();
}

class _DmsDrawerState extends State<HomeScreen> {
  late HomeBloc bloc;

  int _currentIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(
        create: (BuildContext context) =>
            DrawerBloc()..add(DrawerInitialEvent(context: context)),
        child: DashBoardPage()),
    BlocProvider(
        create: (BuildContext context) =>
            WorkorderBloc()..add(WorkOrderEventInitialEvent(context: context)),
        child: WorkOrdersPage(
          result: HttpUrl.getAllAssets,
        )),
    BlocProvider(
        create: (BuildContext context) => ServiceRequestBloc()
          ..add(ServiceRequestInitialEvent(context: context)),
        child: const ServiceRequestPage()),
    BlocProvider(
        create: (BuildContext context) =>
            UrlpageBloc()..add(UrlpageInitialEvent(context: context)),
        child: const MorePage())
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _decrement() {
    setState(() {
      _currentIndex--;
    });
  }

  @override
  void initState() {
    if (widget.index != -1) {
      if (widget.results != '' && widget.results != null) {
        print("checkDataReturn  widget.results != '' && widget.results != null) ${widget.results}");
        _currentIndex = widget.index;
        HttpUrl.resultData = widget.results;
      } else {
        print("checkDataReturn  widget.index  ${widget.index}");
        _currentIndex = widget.index;
      }
    }
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (_currentIndex != 0) {
          _decrement();
        }
        return;
      },
      child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, BaseState state) {
            return Scaffold(
                bottomNavigationBar: ScaffoldWithNavigationBar(
                  body: _screens[_currentIndex],
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onTabTapped,
                ),
                body: _screens[_currentIndex]);
          }),
    );
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: Container(
        height: 65,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white70,
              blurRadius: 4.0,
              // offset: Offset(0.0, 0.75),
            ),
          ],
        ),
        child: NavigationBar(
          indicatorShape: const CircleBorder(),
          indicatorColor: ColorResource.lightGrey2,
          elevation: 4,
          selectedIndex: selectedIndex,
          destinations: const [
            NavigationDestination(
              label: 'Home',
              icon: Icon(Icons.home),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            NavigationDestination(
              label: 'WorkOrder',
              icon: Icon(Icons.content_paste_outlined),
              selectedIcon: Icon(
                Icons.content_paste_outlined,
                color: Colors.blue,
              ),
            ),
            NavigationDestination(
              label: 'Request',
              icon: Icon(Icons.inbox_outlined),
              selectedIcon: Icon(
                Icons.inbox_outlined,
                color: Colors.blue,
              ),
            ),
            NavigationDestination(
              label: 'More',
              icon: Icon(Icons.menu),
              selectedIcon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ],
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}
