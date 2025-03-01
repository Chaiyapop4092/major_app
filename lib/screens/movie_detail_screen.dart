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

  void navigateToSeatSelectionScreen(String cinemaName, String showtime) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeatSelectionScreen(
          cinemaName: cinemaName,
          showtime: showtime,
          selectedDate: selectedDate,
        ),
      ),
    );
  }

  void navigateToBookingScreen(String cinemaName, String showtime) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(
          movieTitle: 'movieTitle',
          moviePoster: 'moviePoster',
          movieGenre: 'movieGenre',
          movieDuration: 5,
          cinemaName: cinemaName,
          showtime: showtime,
          selectedDate: selectedDate,
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
                                    // Navigate to BookingScreen when a showtime is selected
                                    navigateToBookingScreen(cinema['name'], time);
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
            ),
          ],
        ),
      ),
    );
  }
}

class SeatSelectionScreen extends StatefulWidget {
  final String cinemaName;
  final String showtime;
  final DateTime selectedDate;

  SeatSelectionScreen({required this.cinemaName, required this.showtime, required this.selectedDate});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<List<bool>> seats = List.generate(
    5,
    (_) => List.generate(10, (_) => false),
  ); // 5 rows, 10 columns

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Cinema: ${widget.cinemaName}\nTime: ${widget.showtime}\nDate: ${DateFormat('dd MMM yyyy').format(widget.selectedDate)}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 50, // 5 rows * 10 columns
              itemBuilder: (context, index) {
                int row = index ~/ 10;
                int col = index % 10;
                bool isSelected = seats[row][col];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      seats[row][col] = !isSelected;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.grey[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${row + 1}-${col + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                int selectedSeatsCount = seats.fold<int>(
                  0,
                  (count, row) => count + row.where((seat) => seat).length,
                );
                if (selectedSeatsCount > 0) {
                  // Proceed to checkout or confirmation screen
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Seats Selected'),
                      content: Text('You have selected $selectedSeatsCount seats.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Proceed to checkout or confirm booking
                          },
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Show message to select seats
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select at least one seat.')),
                  );
                }
              },
              child: Text('Proceed to Checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
