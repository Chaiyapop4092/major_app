import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final String movieTitle;
  final String genre;
  final String duration;
  final String cinemaName;
  final String theatre;
  final List<String> languages;
  final String rating;
  final String technology;
  final String date;
  final List<String> showTimes;
  final String selectedTime;

  BookingScreen({
    required this.movieTitle,
    required this.genre,
    required this.duration,
    required this.cinemaName,
    required this.theatre,
    required this.languages,
    required this.rating,
    required this.technology,
    required this.date,
    required this.showTimes,
    required this.selectedTime,
  });

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<String> selectedSeats = [];
  List<String> bookedSeats = ['6-8', '6-9', '7-4', '7-5', '8-10'];
  String selectedShowTime = '';

  Map<String, int> seatPrices = {
    'Normal': 280,
    'Premium': 310,
    'Opera': 800,
  };

  List<List<String>> seats = [
    List.filled(16, 'Normal'),
    List.filled(16, 'Normal'),
    List.filled(16, 'Normal'),
    List.filled(16, 'Normal'),
    List.filled(16, 'Normal'),
    List.filled(16, 'Premium'),
    List.filled(16, 'Premium'),
    List.filled(16, 'Premium'),
    List.filled(10, 'Opera') + List.filled(6, 'Opera'),
  ];

  List<String> rowLabels = ['M', 'L', 'K', 'J', 'I', 'H', 'G', 'F', 'E', 'D', 'C', 'B', 'A', 'VP'];

  @override
  void initState() {
    super.initState();
    selectedShowTime = widget.selectedTime;
  }

  void toggleSeatSelection(int row, int col) {
    String seatKey = '$row-$col';
    if (bookedSeats.contains(seatKey)) return;

    setState(() {
      if (selectedSeats.contains(seatKey)) {
        selectedSeats.remove(seatKey);
      } else {
        selectedSeats.add(seatKey);
      }
    });
  }

  int getTotalPrice() {
    int total = 0;
    for (String seat in selectedSeats) {
      List<String> parts = seat.split('-');
      int row = int.parse(parts[0]);
      int col = int.parse(parts[1]);
      total += seatPrices[seats[row][col]]!;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/movie_poster.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0), Colors.black],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.movieTitle,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4),
                  Text('${widget.genre} • ${widget.duration}',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 12),
                  Text("Select Show Time", style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.showTimes.map((time) {
                      bool isSelected = time == selectedShowTime;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedShowTime = time;
                          });
                        },
                        child: Chip(
                          label: Text(time, style: TextStyle(color: isSelected ? Colors.black : Colors.white)),
                          backgroundColor: isSelected ? Colors.amber : Colors.grey[800],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Center(child: Text("SCREEN", style: TextStyle(color: Colors.white, fontSize: 18))),
                  SizedBox(height: 10),

                  // 🪑 Seat Layout with Row Labels
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: seats.length,
                    itemBuilder: (context, row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(rowLabels[row], style: TextStyle(color: Colors.white, fontSize: 16)),
                          SizedBox(width: 8),
                          ...List.generate(seats[row].length, (col) {
                            String seatType = seats[row][col];
                            String seatKey = '$row-$col';

                            bool isSelected = selectedSeats.contains(seatKey);
                            bool isBooked = bookedSeats.contains(seatKey);

                            Color seatColor = isBooked
                                ? Colors.grey
                                : isSelected
                                    ? Colors.amber
                                    : seatType == 'Normal'
                                        ? Colors.red
                                        : seatType == 'Premium'
                                            ? Colors.blue
                                            : Colors.orange;

                            return GestureDetector(
                              onTap: () => toggleSeatSelection(row, col),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.event_seat,
                                  color: seatColor,
                                  size: 32,
                                ),
                              ),
                            );
                          }),
                          SizedBox(width: 8),
                          Text(rowLabels[row], style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSeatTypeIndicator(Colors.red, "Normal", 280),
                      _buildSeatTypeIndicator(Colors.blue, "Premium", 310),
                      _buildSeatTypeIndicator(Colors.orange, "Opera Chair", 800),
                    ],
                  ),
                  SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      onPressed: selectedSeats.isNotEmpty ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: Text("Book Now", style: TextStyle(fontSize: 18, color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatTypeIndicator(Color color, String type, int price) {
    return Column(
      children: [
        Icon(Icons.event_seat, color: color, size: 32),
        SizedBox(height: 4),
        Text(type, style: TextStyle(color: Colors.white, fontSize: 14)),
        Text("฿$price", style: TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
