import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MovieDetailScreen extends StatefulWidget {
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool showBookingScreen = false;
  String selectedCinema = '';
  String selectedTime = '';
  List<String> selectedSeats = [];
  double totalPrice = 0.0;

  void selectCinema(String cinema) {
    setState(() {
      selectedCinema = cinema;
      showBookingScreen = true;
    });
  }

  void selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  void toggleSeatSelection(String seat, double price) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
        totalPrice -= price;
      } else {
        selectedSeats.add(seat);
        totalPrice += price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (showBookingScreen) {
              setState(() {
                showBookingScreen = false;
                selectedSeats.clear();
                totalPrice = 0.0;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: showBookingScreen ? buildBookingScreen() : buildMovieDetails(),
      ),
    );
  }

  Widget buildMovieDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            children: [
              Image.asset('assets/movie_poster.jpg', fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Movie Title',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Synopsis and details...',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: ['Cinema 1', 'Cinema 2', 'Cinema 3'].map((cinema) {
                    return ListTile(
                      title: Text(cinema, style: TextStyle(color: Colors.white)),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onTap: () => selectCinema(cinema),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBookingScreen() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['11:30', '14:10', '16:50', '19:30'].map((time) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    selectedTime == time ? Colors.amber : Colors.grey[800],
                  ),
                ),
                onPressed: () => selectTime(time),
                child: Text(time, style: TextStyle(color: Colors.white)),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 25,
            itemBuilder: (context, index) {
              String seat = 'C${index + 1}';
              double price = 1200.0;
              bool isSelected = selectedSeats.contains(seat);
              return GestureDetector(
                onTap: () => toggleSeatSelection(seat, price),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.amber : Colors.purple,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: isSelected
                        ? Icon(Icons.check, color: Colors.black)
                        : Icon(Icons.event_seat, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.grey[900],
          child: Column(
            children: [
              Text('Selected Seats: ${selectedSeats.join(', ')}', style: TextStyle(color: Colors.white)),
              Text('Total: ฿${totalPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Continue', style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
