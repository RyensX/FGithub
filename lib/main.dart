import 'package:FGithub/Const.dart';
import 'package:FGithub/page/explore.dart';
import 'package:FGithub/page/home.dart';
import 'package:FGithub/page/notification.dart';
import 'package:FGithub/page/profile.dart';
import 'package:FGithub/util/view_util.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const GithubApp());
  setTransparentStatusBar();
}

class GithubApp extends StatelessWidget {
  const GithubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConst.appName,
      theme: ThemeData(
        primarySwatch: AppConst.themeColor,
      ),
      home: const MainPage(title: AppConst.appName),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
