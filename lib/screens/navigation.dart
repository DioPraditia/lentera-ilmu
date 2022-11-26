import 'dart:io';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:lentera_ilmu/screens/Showroom/screen_showroom.dart';
// ignore: unused_import
import 'package:lentera_ilmu/screens/coming_soon_screen.dart';
import 'package:lentera_ilmu/screens/home/home_screen.dart';
import 'package:lentera_ilmu/screens/library/my_library_screen.dart';
import 'package:lentera_ilmu/screens/produk/screen_produk.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int _page = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const MyLibraryScreen(),
    const ScreenProduk(),
    const ScreenShowroom(),
  ];

  Future<bool> backPressed() async {
    bool value = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.white,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        title: Text(
          'Anda yakin akan keluar dari Aplikasi?',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 12),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Batalkan',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 12),
            ),
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: const Text(
              'Keluar',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await backPressed();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.list,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.local_mall,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.store,
                size: 30,
                color: Colors.white,
              ),
            ],
            color: Colors.teal.shade700,
            buttonBackgroundColor: Colors.teal.shade700,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 400),
            onTap: (index) {
              if (_page != index) {
                setState(() {
                  _page = index;
                });
              }
            },
            letIndexChange: (index) => true,
          ),
          body: Container(
            color: Colors.white,
            child: _widgetOptions.elementAt(_page),
          ),
        ),
      ),
    );
  }
}
