import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:major_app/screens/booking_screen.dart';



class MovieDetailScreen extends StatefulWidget {
  @override
  final String title;
  final String genre;
  final String duration;
  final String posterPath;

  const MovieDetailScreen({
    required this.title,
    required this.genre,
    required this.duration,
    required this.posterPath,
    Key? key,
  }) : super(key: key);

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
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Pinklao',
    'distance': '3.59 km',
    'theatre': 'Theatre 5',
    'showtimes': ['10:00', '12:30', '15:00', '17:30'],
    'isExpanded': false,
  },
  {
    'name': 'Paragon Cineplex',
    'distance': '3.73 km',
    'theatre': 'Theatre 9',
    'showtimes': ['11:45', '14:15', '16:45', '19:15'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Supreme',
    'distance': '4.00 km',
    'theatre': 'Theatre 3',
    'showtimes': ['12:00', '14:30', '17:00', '19:30'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Ratchayothin',
    'distance': '5.12 km',
    'theatre': 'Theatre 7',
    'showtimes': ['10:30', '13:00', '15:30', '18:00'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Rangsit',
    'distance': '25.40 km',
    'theatre': 'Theatre 12',
    'showtimes': ['10:00', '12:30', '15:00', '17:30', '20:00'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Bangna',
    'distance': '15.80 km',
    'theatre': 'Theatre 8',
    'showtimes': ['11:00', '13:30', '16:00', '18:30'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Central Westgate',
    'distance': '20.10 km',
    'theatre': 'Theatre 6',
    'showtimes': ['10:15', '12:45', '15:15', '17:45'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Fashion Island',
    'distance': '18.50 km',
    'theatre': 'Theatre 4',
    'showtimes': ['10:45', '13:15', '15:45', '18:15'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Central Rama 2',
    'distance': '22.30 km',
    'theatre': 'Theatre 10',
    'showtimes': ['11:15', '13:45', '16:15', '18:45'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Central Chiangmai',
    'distance': '700 km',
    'theatre': 'Theatre 5',
    'showtimes': ['10:30', '13:00', '15:30', '18:00'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Central Hatyai',
    'distance': '950 km',
    'theatre': 'Theatre 9',
    'showtimes': ['11:00', '13:30', '16:00', '18:30'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Udon Thani',
    'distance': '550 km',
    'theatre': 'Theatre 7',
    'showtimes': ['10:45', '13:15', '15:45', '18:15'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Korat',
    'distance': '260 km',
    'theatre': 'Theatre 3',
    'showtimes': ['11:15', '13:45', '16:15', '18:45'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Central Pattaya',
    'distance': '140 km',
    'theatre': 'Theatre 11',
    'showtimes': ['10:30', '13:00', '15:30', '18:00'],
    'isExpanded': false,
  },
  {
    'name': 'Major Cineplex Central Ubon Ratchathani',
    'distance': '615 km',
    'theatre': 'Theatre 6',
    'showtimes': ['10:00', '12:30', '15:00', '17:30'],
    'isExpanded': false,
  },
];


  Future<void> navigateToBookingScreen(
  BuildContext context, 
  String movieTitle, 
  String cinemaName, 
  String showtime, 
  String theatre, 
  String date,
  String posterPath, 
  Map<String, dynamic> cinema,  // เพิ่มตัวแปร cinema เพื่อรับข้อมูลโรงที่เลือก
) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookingScreen(
        movieTitle: movieTitle,
        genre: widget.genre,
        duration: widget.duration,
        cinemaName: cinemaName,
        theatre: theatre,
        languages: ['TH', 'EN'],
        rating: 'R15',
        technology: 'LASER CINEMA',
        date: date, // ✅ ส่งค่าวันที่ที่เป็น String
        showTimes: cinema['showtimes'], // ใช้ showtimes จาก cinema ที่เลือก
        selectedTime: showtime,
        posterPath: posterPath,
      ),
    ),
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
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
                  widget.posterPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    widget.title,
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
                '${widget.genre} | ${widget.duration}',
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

                      // แปลง selectedDate จาก DateTime เป็น String ก่อนส่งไป
                      String formattedDate = DateFormat('EEE dd MMM yyyy').format(selectedDate);

                      // ส่งข้อมูลไปยัง BookingScreen โดยใช้ค่า showtimes ของ cinema
                      navigateToBookingScreen(
                        context, 
                        widget.title, // ชื่อภาพยนตร์
                        cinema['name'], // ชื่อโรง
                        time, // เวลาฉายที่เลือก
                        cinema['theatre'], // โรงภาพยนตร์
                        formattedDate, // วันที่
                        widget.posterPath, // รูปภาพโปสเตอร์
                        cinema, // ส่งค่า cinema ทั้งหมด
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

