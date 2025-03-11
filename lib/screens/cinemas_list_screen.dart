import 'package:flutter/material.dart';
import 'package:major_app/screens/cinema.screen.dart';

class CinemasListScreen extends StatefulWidget {
  @override
  _CinemasScreenState createState() => _CinemasScreenState();
}

class _CinemasScreenState extends State<CinemasListScreen> {
  int selectedIndex = 0;
  final List<String> tabs = ['All Cinemas', 'Favourites', 'Recents'];

  final List<Map<String, dynamic>> cinemas = [
    {'name': 'ICON CINECONIC', 'distance': '3.43 km'},
    {'name': 'Major Cineplex Pinklao', 'distance': '3.59 km'},
    {'name': 'Paragon Cineplex', 'distance': '3.73 km'},
    {'name': 'Major Cineplex Supreme', 'distance': '4.00 km'},
    {'name': 'Major Cineplex Ratchayothin', 'distance': '5.12 km'},
    {'name': 'Major Cineplex Rangsit', 'distance': '25.40 km'},
    {'name': 'Major Cineplex Bangna', 'distance': '15.80 km'},
    {'name': 'Major Cineplex Central Westgate', 'distance': '20.10 km'},
    {'name': 'Major Cineplex Fashion Island', 'distance': '18.50 km'},
    {'name': 'Major Cineplex Central Rama 2', 'distance': '22.30 km'},
    {'name': 'Major Cineplex Central Chiangmai', 'distance': '700 km'},
    {'name': 'Major Cineplex Central Hatyai', 'distance': '950 km'},
    {'name': 'Major Cineplex Udon Thani', 'distance': '550 km'},
    {'name': 'Major Cineplex Korat', 'distance': '260 km'},
    {'name': 'Major Cineplex Central Pattaya', 'distance': '140 km'},
    {'name': 'Major Cineplex Central Ubon Ratchathani', 'distance': '615 km'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Cinemas', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        elevation: 0,
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
            child: ListView.builder(
              itemCount: cinemas.length,
              itemBuilder: (context, index) {
                final cinema = cinemas[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  title: Text(cinema['name'], style: TextStyle(color: Colors.white)),
                  subtitle: Text(cinema['distance'], style: TextStyle(color: Colors.grey)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star_border, color: Colors.amber),
                      SizedBox(width: 16),
                      Icon(Icons.share, color: Colors.grey),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CinemaScreen(
                          cinemaName: cinema['name'],
                          cinemaImage: "URL ของรูปโรงหนัง",
                          location: "ที่อยู่ของโรงหนัง",
                        ),
                      ),
                    );
                  },
                );
              },
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
}
