import 'package:dms_dealers/router.dart';
import 'package:dms_dealers/screens/drawer/drawer_bloc.dart';
import 'package:dms_dealers/screens/homeScreen/home_bloc.dart';
import 'package:dms_dealers/screens/profile/model/profile_details.dart';
import 'package:dms_dealers/screens/profile/profile_details_screen.dart';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:dms_dealers/utils/contants.dart';
import 'package:dms_dealers/utils/image_resources.dart';
import 'package:dms_dealers/widgets/main_menu_card.dart';
import 'package:dms_dealers/widgets/nav_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import '../../utils/singleton.dart';

import '../drawer/drawer.dart';
import '../drawer/drawer_event.dart';
import '../profile/profile_details_bloc.dart';
import '../profile/profile_details_event.dart';
import '../url_page/urlpage_bloc.dart';
import '../url_page/urlpage_event.dart';
import '../url_page/urlpage_screen.dart';
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
        create: (BuildContext context) => ProfileDetailsBloc()
          ..add(ProfileDetailsEventInitialEvent(context: context)),
        child: const ProfileDetailsScreen()),

    BlocProvider(
        create: (BuildContext context) =>
        UrlpageBloc()..add(UrlpageInitialEvent(context: context)),
        child: const UrlPage())
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
            if (state is ScreenLoadState) {
              return Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: _onTabTapped,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ],
                  ),
                  body: _screens[_currentIndex]);
            }

            return Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: _onTabTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
                body: _screens[_currentIndex]);

          }
      ),
    );



  }
}
