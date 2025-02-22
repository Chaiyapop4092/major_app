import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MajorCloneApp());
}

class MajorCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> movieBanners = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg'
  ];

  final List<Map<String, dynamic>> movies = [
    {'poster': 'assets/images/movie1.jpg', 'title': 'Den of Thieves', 'date': '20 Feb 2025', 'genres': ['Crime', 'Drama']},
    {'poster': 'assets/images/movie2.jpg', 'title': 'Legends of the City', 'date': '20 Feb 2025', 'genres': ['Drama', 'Action']},
  ];

  final List<Map<String, String>> discounts = [
    {'image': 'assets/images/discount1.jpg', 'title': 'Discount 50 THB', 'validity': 'Valid until 26 Feb 2025'}
  ];

  final List<Map<String, dynamic>> comingSoon = [
    {'poster': 'assets/images/coming1.jpg', 'title': 'Eternal Bond', 'date': '27 Feb 2025', 'genres': ['Thriller']},
    {'poster': 'assets/images/coming2.jpg', 'title': 'Mobile Suit Gundam', 'date': '27 Feb 2025', 'genres': ['Drama', 'Action']},
  ];

  final List<Map<String, String>> technologies = [
    {'name': 'IMAX', 'image': 'assets/images/imax.jpg'},
    {'name': '4DX', 'image': 'assets/images/4dx.jpg'},
    {'name': 'Dolby Atmos', 'image': 'assets/images/dolby_atmos.jpg'},
    {'name': 'Kids Cinema', 'image': 'assets/images/kids_cinema.jpg'},
    {'name': 'GLS', 'image': 'assets/images/gls.jpg'},
    {'name': 'ScreenX', 'image': 'assets/images/screenx.jpg'},
    {'name': 'LaserPlex', 'image': 'assets/images/laserplex.jpg'},
    {'name': 'LED Cinema', 'image': 'assets/images/led_cinema.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,  // Make the AppBar background color the same as the dark theme
        title: Row(
          children: [
            Image.asset(
              'assets/images/major_logo.png', // Ensure the path to your logo is correct
              height: 40, // Adjust the size of the logo as needed
            ),
            SizedBox(width: 10),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to login page (replace with actual login screen)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(autoPlay: true, height: 200, enlargeCenterPage: true),
                items: movieBanners.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(url, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              sectionTitle('Now Showing'),
              movieList(movies),
              sectionTitle('Discounts'),
              discountList(discounts),
              sectionTitle('Coming Soon'),
              movieList(comingSoon, isComingSoon: true),
              sectionTitle('Latest Technology'),
              technologyGrid(technologies),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed, // This ensures all 5 items are shown
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
    BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Cinemas'),
    BottomNavigationBarItem(icon: Icon(Icons.discount), label: 'Discount'),
    BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
  ],
  onTap: (index) {
    // Handle navigation when an item is tapped
    // Example: switch between different screens (you may need to create different screens for each tab)
    switch (index) {
      case 0:
        // Navigate to Home
        break;
      case 1:
        // Navigate to Movies
        break;
      case 2:
        // Navigate to Cinemas
        break;
      case 3:
        // Navigate to Discounts
        break;
      case 4:
        // Navigate to More
        break;
      default:
        break;
    }
  },
),

    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget movieList(List<Map<String, dynamic>> movies, {bool isComingSoon = false}) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(movie['poster'], width: 100, height: 150, fit: BoxFit.cover),
                ),
                SizedBox(height: 5),
                Text(movie['title'], style: TextStyle(fontWeight: FontWeight.bold)),
                Text(movie['date'], style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget discountList(List<Map<String, String>> discounts) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: discounts.length,
        itemBuilder: (context, index) {
          final discount = discounts[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(discount['image']!, width: 100, height: 80, fit: BoxFit.cover),
                SizedBox(height: 5),
                Text(discount['title']!),
                Text(discount['validity']!, style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget technologyGrid(List<Map<String, String>> technologies) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: technologies.length,
        itemBuilder: (context, index) {
          final technology = technologies[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  technology['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 5),
              Text(
                technology['name']!,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}

// Dummy LoginPage for navigation
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(child: Text('Login Page')),
    );
  }
}
