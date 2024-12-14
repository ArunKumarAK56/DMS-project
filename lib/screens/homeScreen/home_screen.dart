import 'package:dms_dealers/router.dart';
import 'package:dms_dealers/screens/drawer/drawer_bloc.dart';
import 'package:dms_dealers/screens/homeScreen/home_bloc.dart';
import 'package:dms_dealers/screens/morePage/more_page_screen.dart';
import 'package:dms_dealers/screens/profile/model/profile_details.dart';
import 'package:dms_dealers/screens/profile/profile_details_screen.dart';
import 'package:dms_dealers/screens/woroOrder/bloc/workorder_bloc.dart';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:dms_dealers/utils/contants.dart';
import 'package:dms_dealers/utils/image_resources.dart';
import 'package:dms_dealers/widgets/main_menu_card.dart';
import 'package:dms_dealers/widgets/nav_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../base/base_state.dart';
import '../drawer/drawer.dart';
import '../drawer/drawer_event.dart';
import '../profile/profile_details_bloc.dart';
import '../profile/profile_details_event.dart';
import '../serviceRequestPage/serive_request_bloc.dart';
import '../serviceRequestPage/service_request_event.dart';
import '../serviceRequestPage/service_request_page.dart';
import '../url_page/urlpage_bloc.dart';
import '../url_page/urlpage_event.dart';
import '../url_page/urlpage_screen.dart';
import '../woroOrder/work_order.dart';
import 'home_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _DmsDrawerState();
}

class _DmsDrawerState extends State<HomeScreen> {
  late HomeBloc bloc;
  String mobileno = "";
  String name = "";
  String username = "";
  String designation = "";
  String emailid = "";
  String address = "";
  late ProfileData profileData;
  String ProductName = "";
  String ChasisNo = "";
  final List<Map<String, String>> navMenu = [
    {'img': ImageResource.vehicle2, 'title': Constants.aboutVahicle},
    {'img': ImageResource.service, 'title': Constants.service},
    {'img': ImageResource.spare, 'title': Constants.spare}
  ];

  int _currentIndex = 0;

  final List<Widget> _screens = [

    BlocProvider(
        create: (BuildContext context) =>
            DrawerBloc()..add(DrawerInitialEvent(context: context)),
        child: DashBoardPage()),

    BlocProvider(
        create: (BuildContext context) =>
        WorkorderBloc()..add(WorkOrderEventInitialEvent(context: context)),
        child:  WorkOrdersPage()),

    BlocProvider(
        create: (BuildContext context) =>
        ServiceRequestBloc()..add(ServiceRequestInitialEvent(context: context)),
        child: const ServiceRequestPage())   ,

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

  void navigateToScreen(String title) {
    print("title$title");
    switch (title) {
      case Constants.aboutVahicle:
        // BlocProvider(
        //       create: (BuildContext context) =>
        //       AboutVehicleBloc()..add(AboutVehicleInitialEvent(context: context)),
        //       child: const AboutVahicle());

        // Navigator.pushNamed(context, AppRoutes.aboutVahicle);
        break;
      case Constants.service:
        // Navigator.pushNamed(context, AppRoutes.serviceWarranty);
        break;
      case Constants.spare:
        // Navigator.pushNamed(context, AppRoutes.spareScreen);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
  }



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
          if(_currentIndex!=0){
            _decrement();
          }
          return;
      },
      child:  BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, BaseState state) {
            // if (state is ScreenLoadState) {
              return Scaffold(
                  bottomNavigationBar:ScaffoldWithNavigationBar(
                    body:_screens[_currentIndex],
                    selectedIndex:_currentIndex,
                    onDestinationSelected: _onTabTapped,
                  ),

                  body: _screens[_currentIndex]);
            // }
            //
            // return Scaffold(
            //     bottomNavigationBar: BottomNavigationBar(
            //       currentIndex: _currentIndex,
            //       onTap: _onTabTapped,
            //       items: [
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.home),
            //           label: 'Home',
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.person),
            //           label: 'Profile',
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.settings),
            //           label: 'Settings',
            //         ),
            //       ],
            //     ),
            //     body: _screens[_currentIndex]);

          }
      ),
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
          indicatorColor: Colors.grey,
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
            NavigationDestination(label: 'More',   icon: Icon(Icons.menu),
              selectedIcon: Icon(
                Icons.menu,
                color: Colors.black,
              ),),
          ],
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}
