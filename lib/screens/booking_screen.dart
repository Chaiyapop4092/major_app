import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> bookedSeats = [];
  String selectedShowTime = '';
  Map<String, List<String>> bookedSeatsForShowTime = {}; // เก็บที่นั่งที่จองตามรอบหนัง
  
  

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
    _generateBookedSeats();
    _loadBookedSeatsForShowTime(); // โหลดที่นั่งที่จองสำหรับรอบแรก
  }
 void _loadBookedSeatsForShowTime() {
    // ตรวจสอบว่ามีที่นั่งที่จองแล้วสำหรับรอบนี้หรือไม่
    if (!bookedSeatsForShowTime.containsKey(selectedShowTime)) {
      _generateBookedSeatsForShowTime(); // ถ้าไม่มี ให้สุ่มที่นั่งที่จองใหม่
    } else {
      setState(() {
        bookedSeats = bookedSeatsForShowTime[selectedShowTime]!; // โหลดที่นั่งที่จอง
      });
    }
  }
void _generateBookedSeatsForShowTime() {
    final Random random = Random(widget.cinemaName.hashCode + 
                                   widget.theatre.hashCode + 
                                   selectedShowTime.hashCode + 
                                   widget.date.hashCode); // เพิ่มวันและเวลาลงในคีย์การสุ่ม

    Set<String> bookedSet = {};
    int totalSeats = seats.expand((row) => row).length;
    int bookedCount = (totalSeats * 0.15).toInt(); // สุ่มให้ประมาณ 15% ของที่นั่งถูกจอง

    while (bookedSet.length < bookedCount) {
      int row = random.nextInt(seats.length);
      int col = random.nextInt(seats[row].length);
      bookedSet.add('$row-$col');
    }

    setState(() {
      bookedSeats = bookedSet.toList();
      bookedSeatsForShowTime[selectedShowTime] = bookedSeats; // เก็บที่นั่งที่จองสำหรับรอบนี้
    });
  }

 void _generateBookedSeats() {
  final Random random = Random(widget.cinemaName.hashCode + 
                                 widget.theatre.hashCode + 
                                 widget.selectedTime.hashCode + 
                                 widget.date.hashCode); // เพิ่มวันและเวลาลงในคีย์การสุ่ม

  Set<String> bookedSet = {};
  int totalSeats = seats.expand((row) => row).length;
  int bookedCount = (totalSeats * 0.15).toInt(); // สุ่มให้ประมาณ 15% ของที่นั่งถูกจอง

  while (bookedSet.length < bookedCount) {
    int row = random.nextInt(seats.length);
    int col = random.nextInt(seats[row].length);
    bookedSet.add('$row-$col');
  }

  setState(() {
    bookedSeats = bookedSet.toList();
  });
}
  void updateBookedSeatsForNewShowTime() {
    // อัปเดตที่นั่งจองสำหรับรอบใหม่
    if (!bookedSeatsForShowTime.containsKey(selectedShowTime)) {
      _generateBookedSeatsForShowTime();
    } else {
      setState(() {
        bookedSeats = bookedSeatsForShowTime[selectedShowTime]!; // โหลดที่นั่งที่จองจากรอบนั้น
      });
    }
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
double _calculateAspectRatio(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  // ตั้งค่าขนาด childAspectRatio ตามขนาดหน้าจอ
  double aspectRatio = screenWidth / screenHeight;

  // ควบคุมอัตราส่วน (ตัวเลข 1.0 เป็นค่าที่นั่งสี่เหลี่ยม)
  if (aspectRatio > 1.5) {
    return 1.2; // หน้าจอใหญ่ (เช่น 16:9)
  } else {
    return 1.5; // หน้าจอเล็ก
  }
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
    updateBookedSeatsForNewShowTime(); // อัปเดตที่นั่งที่จองใหม่
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
  child: LayoutBuilder(
    builder: (context, constraints) {
      // คำนวณขนาดของที่นั่งตามขนาดหน้าจอ
      double seatSize = constraints.maxWidth / seats[row].length * 0.8; // เพิ่มขนาดที่นั่ง
      seatSize = max(seatSize, 40.0);  // กำหนดขนาดขั้นต่ำของที่นั่ง

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: seats[row].length, // คงที่ตามข้อมูล
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: seatSize / seatSize, // ควบคุมขนาดที่นั่ง
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
              padding: const EdgeInsets.all(2.0), // ลด padding รอบๆ ที่นั่ง
              child: Container(
                width: seatSize, // ขนาดของที่นั่ง
                height: seatSize, // ขนาดของที่นั่ง
                decoration: BoxDecoration(
                  // กำหนดสีของที่นั่งตรงนี้แทนพื้นหลัง
                  color: Colors.transparent, // พื้นหลังล่องหน
                  borderRadius: BorderRadius.circular(16), // มุมโค้งมน
                ),
                child: Center(
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
                    size: seatSize * 0.6, // ไอคอนปรับขนาดให้พอดีกับที่นั่ง
                  ),
                ),
              ),
            ),
          );
        },
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
      // เมื่อกดปุ่ม Continue
ElevatedButton(
  onPressed: selectedSeats.isNotEmpty ? () {
    // แสดง Dialog เมื่อเลือกที่นั่งแล้ว
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Completed', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Thank you for your booking!', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Your selected seats: ${selectedSeats.map((s) {
                List<String> parts = s.split('-');
                String rowLabel = rowLabels[int.parse(parts[0])];
                return "$rowLabel${int.parse(parts[1]) + 1}";
              }).join(', ')}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text('Total: ฿${getTotalPrice().toStringAsFixed(2)}', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // อัปเดตที่นั่งให้ถูกจองแล้ว
                setState(() {
                  for (String seat in selectedSeats) {
                    bookedSeats.add(seat); // เพิ่มที่นั่งที่เลือกเข้าไปใน bookedSeats
                  }
                  selectedSeats.clear(); // เคลียร์ที่นั่งที่เลือกหลังจากจ่ายเงินเสร็จ
                });
                Navigator.of(context).pop(); // ปิด Dialog
              },
              child: Text('OK', style: TextStyle(color: Colors.amber)),
            ),
          ],
        );
      },
    );
  } : null,
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

