import 'package:flutter/material.dart';
import 'package:twitch/screens/feed_screen.dart';
import 'package:twitch/screens/go_live_screen.dart';
import 'package:twitch/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 1;
  List<Widget> pages = [
    const FeedScreen(),
    const GoLiveScreen(),
    const Center(
      child: Text('Browser'),
    ),
  ];
  onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: primaryColor,
          selectedItemColor: buttonColor,
          backgroundColor: backgroundColor,
          onTap: onPageChange,
          currentIndex: _page,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Following',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_rounded,
              ),
              label: 'Go Live',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.copy,
              ),
              label: 'Browse',
            ),
          ]),
      body: pages[_page],
    );
  }
}
