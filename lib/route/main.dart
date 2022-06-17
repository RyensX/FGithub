import 'package:FGithub/Const.dart';
import 'package:FGithub/page/explore.dart';
import 'package:FGithub/page/home.dart';
import 'package:FGithub/page/notification.dart';
import 'package:FGithub/page/profile.dart';
import 'package:FGithub/util/view_util.dart';
import 'package:flutter/material.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  var allPages = [
    const HomePage(),
    const NotificationPage(),
    const ExplorePage(),
    const ProfilePage()
  ];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allPages[currentIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppConst.themeColor.shade500,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_sharp),
            label: PageConst.homePageName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: PageConst.notificationPageName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: PageConst.explorePageName,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: PageConst.profilePageName,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
