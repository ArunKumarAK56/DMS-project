import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../utils/color_resources.dart';
import '../assetScreen/assets_page.dart';
import '../partScreen/part_screen.dart';

class MorePage extends StatefulWidget {
  final void Function()? ontap;
  const MorePage({super.key, this.ontap});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorResource.statusBarColor,
      statusBarIconBrightness: Brightness.dark, // Change the icons' brightness
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            'More',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20,),
          buildListTile(
            title: 'Assets',
            icon: Icons.square_rounded,
            tileColor: Colors.amber.shade100,
            iconColor: Colors.red.shade300,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const AssetsPage(),
                  ));
            },
          ),
          buildListTile(
            title: 'Parts Inventory',
            icon: Icons.hexagon_outlined,
            tileColor: Colors.blue.shade100,
            iconColor: Colors.purple.shade300,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const PartsPage(),
                  ));

            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required IconData icon,
    required Color tileColor,
    required Color iconColor,
    void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: ListTile(
        onTap: onTap,
        tileColor: tileColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title),
        trailing: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
