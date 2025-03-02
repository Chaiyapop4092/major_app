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
  final String posterPath;

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
    required this.posterPath,
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
                      image: AssetImage(widget.posterPath),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // 🔥 แถวซ้าย (ตัวอักษรแถว)
          SizedBox(
            width: 32, // กำหนดพื้นที่แน่นอน
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                rowLabels[row],
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          SizedBox(width: 8),

          // 🔥 GridView ที่นั่ง
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: seats[row].length, // คงที่ตามข้อมูล
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 1.2,
              ),
              itemCount: seats[row].length,
              itemBuilder: (context, col) {
                String seatType = seats[row][col];
                String seatKey = '$row-$col';

                bool isSelected = selectedSeats.contains(seatKey);
                bool isBooked = bookedSeats.contains(seatKey);

                return GestureDetector(
                  onTap: () => toggleSeatSelection(row, col),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(
                      isBooked
                          ? Icons.event_seat
                          : isSelected
                              ? Icons.check_circle
                              : Icons.event_seat,
                      color: isBooked
                          ? Colors.grey
                          : isSelected
                              ? Colors.green
                              : seatType == 'Normal'
                                  ? Colors.red
                                  : seatType == 'Premium'
                                      ? Colors.blue
                                      : Colors.orange,
                      size: 32,
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(width: 8),

          // 🔥 แถวขวา (ตัวอักษรแถว)
          SizedBox(
            width: 32, // กำหนดพื้นที่แน่นอน
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                rowLabels[row],
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  },
),







                  SizedBox(height: 20),

                  Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    _buildSeatTypeIndicator(Colors.red, Icons.event_seat, "Normal", 280),
    _buildSeatTypeIndicator(Colors.blue, Icons.event_seat, "Premium", 310),
    _buildSeatTypeIndicator(Colors.orange, Icons.weekend, "Opera Chair", 800),
  ],
),





                  SizedBox(height: 20),

                  SizedBox(height: 20),

Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.grey[900],
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Selected Seats", style: TextStyle(color: Colors.white, fontSize: 16)),
          Text("Total", style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
      SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedSeats.map((s) {
              List<String> parts = s.split('-');
              String rowLabel = rowLabels[int.parse(parts[0])];
              return "$rowLabel${int.parse(parts[1]) + 1}";
            }).join(', '),
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "฿${getTotalPrice().toStringAsFixed(2)}",
            style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(height: 16),

      // Input Field
      TextField(
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "Mobile Number",
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[800]!),
          ),
        ),
      ),
      SizedBox(height: 16),

      // Continue Button
      ElevatedButton(
        onPressed: selectedSeats.isNotEmpty ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedSeats.isNotEmpty ? Colors.amber : Colors.grey[800],
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Center(
          child: Text(
            "Continue",
            style: TextStyle(fontSize: 16, color: selectedSeats.isNotEmpty ? Colors.black : Colors.grey),
          ),
        ),
      ),

      SizedBox(height: 12),

      // Terms and Privacy
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 12),
          children: [
            TextSpan(text: "By continuing, you agree to our "),
            TextSpan(
              text: "Terms of Service",
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: " and "),
            TextSpan(
              text: "Privacy Policy",
              style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
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

  

Widget _buildSeatTypeIndicator(Color borderColor, IconData icon, String type, int price) {
  return Container(
    width: 110,
    padding: EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor, width: 2),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: borderColor, size: 32),
        SizedBox(height: 8),
        Text(type, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text("฿$price", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}



}
