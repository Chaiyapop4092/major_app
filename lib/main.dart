import 'package:flutter/material.dart';
import 'package:major_app/screens/cinemas_list_screen.dart';
import 'package:major_app/screens/discount_screen.dart';
import 'package:major_app/screens/home_screen.dart';
import 'package:major_app/screens/more_screen.dart';
import 'package:major_app/screens/movie_detail_screen.dart';
import 'package:major_app/screens/movies_screen.dart';

void main() {
  runApp(MajorCloneApp());
}

class MajorCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Major Cineplex Clone',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Track selected tab

  final List<Widget> _screens = [
    HomeScreen(),
    MoviesScreen(),
    CinemasListScreen(),
    DiscountsScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF2B2B2B), // Dark Grey Background (Matches Major Cineplex)
          selectedItemColor: Color(0xFFFFC107), // Gold/Yellow for selected tab
          unselectedItemColor: Colors.grey[400], // Light Grey for unselected icons
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Cinemas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.discount),
              label: 'Discounts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
