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
  String selectedTime;

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
  List<String> bookedSeats = ['2-3', '2-4', '2-5', '5-7', '5-8']; // ตัวอย่างที่นั่งถูกจอง

  Map<String, int> seatPrices = {
    'Normal': 280,
    'Premium': 310,
    'Opera': 800,
  };

  List<List<String>> seats = [
    List.filled(10, 'Normal'),
    List.filled(10, 'Normal'),
    List.filled(10, 'Normal'),
    List.filled(10, 'Normal'),
    List.filled(10, 'Premium'),
    List.filled(10, 'Premium'),
    List.filled(10, 'Premium'),
    List.filled(10, 'Opera'),
  ];

  void toggleSeatSelection(int row, int col) {
    String seatKey = '$row-$col';
    if (bookedSeats.contains(seatKey)) return; // ห้ามเลือกที่จองแล้ว

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

                  // 📍 Theatre Information
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          'Theatre ${widget.theatre}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.volume_up, color: Colors.white, size: 18),
                        SizedBox(width: 4),
                        ...widget.languages.map((lang) => Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(lang, style: TextStyle(color: Colors.white, fontSize: 14)),
                              ),
                            )),
                      ],
                    ),
                  ),

                  // 🎟️ Rating & Technology Labels
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.rating,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        widget.technology,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // 📅 วันที่
                  Text(widget.date, style: TextStyle(fontSize: 16, color: Colors.white)),
                  SizedBox(height: 12),

                  // ⏰ เลือกเวลาฉาย
                  Row(
                    children: widget.showTimes.map((time) {
                      bool isSelected = time == widget.selectedTime;
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.selectedTime = time; // อัปเดตเวลาที่เลือก
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: isSelected ? Colors.amber : Colors.white),
                              borderRadius: BorderRadius.circular(8),
                              color: isSelected ? Colors.amber : Colors.transparent,
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),

                  // 🪑 Seat Layout
                  Center(child: Text("SCREEN", style: TextStyle(color: Colors.white, fontSize: 18))),
                  SizedBox(height: 10),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: seats.length * seats[0].length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: seats[0].length,
                      childAspectRatio: 1.0,
                    ),
                    itemBuilder: (context, index) {
                      int row = index ~/ seats[0].length;
                      int col = index % seats[0].length;
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
                        child: Icon(Icons.event_seat, color: seatColor, size: 32),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
