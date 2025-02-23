import 'package:flutter/material.dart';

class CinemasScreen extends StatefulWidget {
  @override
  _CinemasScreenState createState() => _CinemasScreenState();
}

class _CinemasScreenState extends State<CinemasScreen> {
  int selectedIndex = 0;
  final List<String> tabs = ['All Cinemas', 'Favourites', 'Recents'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Cinemas', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Cinemas'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Gifts'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: tabs.asMap().entries.map((entry) {
                int idx = entry.key;
                String text = entry.value;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = idx;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedIndex == idx ? Colors.amber : Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: selectedIndex == idx ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search a cinema',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Nearby Cinemas', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                _cinemaTile('ICON CINECONIC', '3.43 km'),
                _cinemaTile('Major Cineplex Pinklao', '3.59 km'),
                _cinemaTile('Paragon Cineplex', '3.73 km'),
                _cinemaTile('Krungsri IMAX LASER Paragon Cineplex', '3.81 km'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {},
        icon: Icon(Icons.map, color: Colors.black),
        label: Text('MAP', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _cinemaTile(String name, String distance) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      title: Text(name, style: TextStyle(color: Colors.white)),
      subtitle: Text(distance, style: TextStyle(color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_border, color: Colors.amber),
          SizedBox(width: 16),
          Icon(Icons.share, color: Colors.grey),
        ],
      ),
    );
  }
}
