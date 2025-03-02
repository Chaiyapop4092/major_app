import 'package:flutter/material.dart';

class CinemaScreen extends StatelessWidget {
  final String cinemaName;
  final String cinemaImage;
  final String location;

  CinemaScreen({
    required this.cinemaName,
    required this.cinemaImage,
    required this.location,
  });

  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Eternal Bond',
      'genre': 'Thriller',
      'rate': '15',
      'duration': '112min',
      'image': 'URL_POSTER_ETERNAL_BOND',
      'theatre': '11',
      'languages': ['TH', 'EN'],
      'rating': 'R15',
      'format': 'LASER',
      'showtimes': ['11:30', '14:00', '16:30', '19:00'],
      'highlight': null,
    },
    {
      'title': 'The Monkey',
      'genre': 'Horror',
      'rate': '18',
      'duration': '98min',
      'image': 'URL_POSTER_THE_MONKEY',
      'theatre': '7',
      'languages': ['EN', 'TH'],
      'rating': 'R18',
      'format': 'ATMOS',
      'showtimes': ['11:30', '14:00', '16:30', '19:00'],
      'highlight': 'Dolby Atmos',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(cinemaImage, width: double.infinity, height: 200, fit: BoxFit.cover),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cinemaName, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(location, style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          _buildDateSelector(),
          _buildCinemaTypes(),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _movieCard(movie);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _dateTile('Today', '2', true),
            _dateTile('Mon', '3', false),
            _dateTile('Tue', '4', false),
            _dateTile('Wed', '5', false),
            _dateTile('Thu', '6', false),
            _dateTile('Fri', '7', false),
            _dateTile('Sat', '8', false),
            _dateTile('Sun', '9', false),
          ],
        ),
      ),
    );
  }

  Widget _dateTile(String day, String date, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day, style: TextStyle(color: isSelected ? Colors.black : Colors.white)),
            Text(date, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCinemaTypes() {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _cinemaType('IMAX'),
            _cinemaType('4DX'),
            _cinemaType('Screen X'),
            _cinemaType('Dolby Atmos'),
            _cinemaType('Kids Cinema'),
            _cinemaType('4K Cinema'),
            _cinemaType('VIP Theater'),
          ],
        ),
      ),
    );
  }

  Widget _cinemaType(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(name, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _movieCard(Map<String, dynamic> movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(movie['image'], width: 80, height: 120, fit: BoxFit.cover),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie['title'], 
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(movie['genre'], style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 4),
                    Text("Rate: ${movie['rate']} | ${movie['duration']}", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8,
              children: [
                ...movie['languages'].map((lang) => Text(lang, style: TextStyle(color: Colors.white))).toList(),
                Text(movie['rating'], style: TextStyle(color: Colors.white, backgroundColor: Colors.grey)),
                if (movie['highlight'] != null)
                  Text(movie['highlight'], style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: movie['showtimes'].map<Widget>((time) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
                    child: Text(time, style: TextStyle(color: Colors.white)),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
