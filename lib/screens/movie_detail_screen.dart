import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:major_app/screens/booking_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieDetailScreen(),
    );
  }
}

class MovieDetailScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieDetailScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  List<Map<String, dynamic>> cinemas = [
    {
      'name': 'ICON CINECONIC',
      'distance': '3.43 km',
      'theatre': 'Theatre 11',
      'showtimes': ['11:30', '14:00', '16:30', '19:00', '21:30'],
      'isExpanded': true,
    },
    {
      'name': 'Major Cineplex Pinklao',
      'distance': '3.59 km',
      'isExpanded': false,
    },
    {
      'name': 'Paragon Cineplex',
      'distance': '3.73 km',
      'isExpanded': false,
    },
    {
      'name': 'Major Cineplex Supreme',
      'distance': '4.00 km',
      'isExpanded': false,
    },
  ];

  Future<void> navigateToBookingScreen(
  BuildContext context, 
  String movieTitle, 
  String cinemaName, 
  String showtime, 
  String theatre, 
  String date // ✅ เปลี่ยนจาก DateTime เป็น String
) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookingScreen(
        movieTitle: movieTitle,
        genre: 'Thriller',
        duration: '112 min',
        cinemaName: cinemaName,
        theatre: theatre,
        languages: ['TH', 'EN'],
        rating: 'R15',
        technology: 'LASER CINEMA',
        date: date, // ✅ ส่งค่าวันที่ที่เป็น String
        showTimes: ['11:30', '14:00', '16:30', '19:00'], // รายการเวลาฉายทั้งหมด
        selectedTime: showtime,
      ),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Eternal Bond'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/eternal_bond.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    'Eternal Bond',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Thriller | Rate: 15 | 110 min',
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
            ),

            

            Divider(color: Colors.grey[800]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    DateTime date = DateTime.now().add(Duration(days: index));
                    bool isToday = index == 0;
                    bool isSelected = date.year == selectedDate.year && date.month == selectedDate.month && date.day == selectedDate.day;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.amber : Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[600]!),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isToday ? 'Today' : DateFormat('EEE').format(date),
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextField(
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: 'Search a cinema',
      hintStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(Icons.search, color: Colors.white),
    ),
    onChanged: (value) {
      setState(() {
        //searchQuery = value.toLowerCase();
      });
    },
  ),
),
            Divider(color: Colors.grey[800]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Nearby',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: cinemas.length,
  itemBuilder: (context, index) {
    var cinema = cinemas[index];
    return ExpansionTile(
      title: Text(
        cinema['name'],
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      subtitle: Text(cinema['distance'], style: TextStyle(color: Colors.grey[500])),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_border, color: Colors.amber),
          SizedBox(width: 10),
          Icon(Icons.share, color: Colors.white),
        ],
      ),
      children: cinema.containsKey('showtimes')
    ? [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            children: cinema['showtimes'].map<Widget>((time) {
              bool isTimeSelected = time == selectedTime;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTime = time;
                  });

                  // ✅ แปลง selectedDate จาก DateTime เป็น String ก่อนส่งไป
                  String formattedDate = DateFormat('EEE dd MMM yyyy').format(selectedDate);

                  navigateToBookingScreen(

  context, 
  'Eternal Bond', 
  cinema['name'],
  time,
  cinema['theatre'], 
  formattedDate, // ✅ แก้ให้ส่งค่าวันที่ไปด้วย


);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: isTimeSelected ? Colors.amber : Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isTimeSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ]
    : [],
    );
  },
)

          ],
        ),
      ),
    );
  }
}

