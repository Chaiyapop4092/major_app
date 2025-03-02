import 'package:flutter/material.dart';

class CinemaScreen extends StatefulWidget {
  final String cinemaName;
  final String cinemaImage;
  final String location;

  const CinemaScreen({
    Key? key,
    required this.cinemaName,
    required this.cinemaImage,
    required this.location,
  }) : super(key: key);

  @override
  _CinemaScreenState createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  int selectedDateIndex = 0;
  final List<String> dates = ['2', '3', '4', '5', '6', '7', '8', '9'];
  final List<String> days = ['Today', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> formats = ['IMAX', '4DX', 'Screen X', 'Dolby Atmos', 'Kids Cinema'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(widget.cinemaImage, fit: BoxFit.cover, width: double.infinity, height: 200),
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.white),
                    SizedBox(width: 16),
                    Icon(Icons.info_outline, color: Colors.white),
                    SizedBox(width: 16),
                    Icon(Icons.star_border, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.cinemaName, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(widget.location, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                bool isSelected = index == selectedDateIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDateIndex = index;
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(days[index], style: TextStyle(color: isSelected ? Colors.black : Colors.white)),
                        Text(dates[index], style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: formats.map((format) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(child: Text(format, style: TextStyle(color: Colors.white, fontSize: 16))),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
