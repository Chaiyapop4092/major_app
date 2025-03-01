import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String movieTitle;
  final String moviePoster;
  final String movieGenre;
  final int movieDuration;

  BookingScreen({
    required this.movieTitle,
    required this.moviePoster,
    required this.movieGenre,
    required this.movieDuration, required String cinemaName, required String showtime, required DateTime selectedDate,
  });

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  List<List<bool>> seats = List.generate(
    5,
    (_) => List.generate(10, (_) => false),
  ); // 5 แถว, 10 คอลัมน์

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking - ${widget.movieTitle}'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // แสดงรายละเอียดภาพยนตร์
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.black,
              child: Row(
                children: [
                  Image.asset(
                    widget.moviePoster,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movieTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${widget.movieGenre} | ${widget.movieDuration} min',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[800]),
            // เลือกวันที่
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Date',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            // ปฏิทินเลือกวันที่
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  );
                  if (pickedDate != null && pickedDate != selectedDate)
                    setState(() {
                      selectedDate = pickedDate;
                    });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[600]!),
                  ),
                  child: Text(
                    DateFormat('EEEE, MMM d, yyyy').format(selectedDate),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey[800]),
            // เลือกเวลา
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Time',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            // ตัวเลือกเวลาฉาย
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 10,
                children: ['11:30', '14:00', '16:30', '19:00', '21:30']
                    .map((time) {
                  bool isSelected = time == selectedTime;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.amber
                            : Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Divider(color: Colors.grey[800]),
            // เลือกที่นั่ง
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Seats',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            // แผนที่ที่นั่ง
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 50, // 5 แถว * 10 คอลัมน์
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
                        color: isSelected
                            ? Colors.amber
                            : Colors.grey[700],
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
            Divider(color: Colors.grey[800]),
            // ปุ่มยืนยันการจอง
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
                        content: Text(
                            'You have selected $selectedSeatsCount seats.'),
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
      ),
    );
  }
}
 
