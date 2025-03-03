import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:major_app/main.dart';
import 'package:major_app/screens/discount_screen.dart';
import 'package:major_app/screens/movie_detail_screen.dart';

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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;  // Keep track of the current banner index

  final List<String> movieBanners = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg'
  ];

  final List<Map<String, dynamic>> movies = [
    {'poster': 'assets/images/movie1.jpg', 'title': 'Den of Thieves', 'date': '20 Feb 2025', 'genres': ['Crime', 'Drama']},
    {'poster': 'assets/images/movie2.jpg', 'title': 'Legends of the City', 'date': '20 Feb 2025', 'genres': ['Drama', 'Action']},
    {'poster': 'assets/images/movie3.jpg', 'title': 'Happy Mondays', 'date': '20 Feb 2025', 'genres': ['Comedy', 'Romance']},
    {'poster': 'assets/images/movie4.jpg', 'title': 'Cleaner', 'date': '20 Feb 2025', 'genres': ['Drama', 'Action']},
    {'poster': 'assets/images/movie5.jpg', 'title': 'Captain America Brave New World', 'date': '20 Feb 2025', 'genres': ['Action', 'Adventure']},
    {'poster': 'assets/images/movie6.jpg', 'title': 'Nosferatu', 'date': '20 Feb 2025', 'genres': ['Drama', 'Horror']},
    {'poster': 'assets/images/movie7.jpg', 'title': 'Attack on Titan: The Last Attack', 'date': '20 Feb 2025', 'genres': ['Drama', 'Action']},
  ];

  final List<Map<String, String>> discounts = [
    {'image': 'assets/images/discount1.jpg', 'title': 'Discount 50 THB', 'validity': 'Valid until 26 Feb 2025'},
    {'image': 'assets/images/discount2.jpg', 'title': 'Discount 100 THB', 'validity': 'Valid until 26 Feb 2025'},
    {'image': 'assets/images/discount3.jpg', 'title': 'Discount 69 THB', 'validity': 'Valid until 26 Feb 2025'},
  ];

  final List<Map<String, dynamic>> comingSoon = [
    {'poster': 'assets/images/coming1.jpg', 'title': 'Eternal Bond', 'date': '27 Feb 2025', 'genres': ['Thriller']},
    {'poster': 'assets/images/coming2.jpg', 'title': 'Mobile Suit Gundam', 'date': '27 Feb 2025', 'genres': ['Drama', 'Action']},
    {'poster': 'assets/images/coming3.jpg', 'title': 'The Brutalist', 'date': '27 Feb 2025', 'genres': ['Drama']},
    {'poster': 'assets/images/coming4.jpg', 'title': 'The Monkey', 'date': '27 Feb 2025', 'genres': ['Horror']},
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
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );*/
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
  options: CarouselOptions(
    autoPlay: true,
    height: MediaQuery.of(context).size.width * 0.55, // ปรับขนาดอัตโนมัติ
    enlargeCenterPage: true,
    viewportFraction: 0.9, // ลดช่องว่างของภาพข้างๆ
    onPageChanged: (index, reason) {
      setState(() {
        _currentIndex = index;
      });
    },
  ),
  items: movieBanners.asMap().entries.map((entry) {
    int index = entry.key;
    String url = entry.value;

    return GestureDetector(
      onTap: () {
        if (index < movies.length) {
          final movie = movies[index];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                title: movie['title'],
                genre: movie['genres'].join(', '),
                duration: movie['date'],
                posterPath: movie['poster'],
              ),
            ),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AspectRatio(
          aspectRatio: 16 / 9, // บังคับให้ภาพไม่ผิดสัดส่วน
          child: Image.asset(
            url,
            fit: BoxFit.cover, // รูปเต็มพื้นที่โดยไม่เสียสัดส่วน
            width: double.infinity,
          ),
        ),
      ),
    );
  }).toList(),
),


              SizedBox(height: 10),
              // Dots below the banner
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: movieBanners.map((url) {
                  int index = movieBanners.indexOf(url);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color(0xFFFFC107)  // Custom yellow color for the selected dot
                          : Colors.grey,  // Grey for unselected dots
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              sectionTitle('Now Showing'),
              movieList(movies),
              //sectionTitle('Discounts'),
              discountList(context, discounts),

              sectionTitle('Coming Soon'),
              movieList(comingSoon, isComingSoon: true),
              sectionTitle('Latest Technology'),
              technologyGrid(technologies),
            ],
          ),
        ),
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
  double screenWidth = MediaQuery.of(context).size.width;
  double posterWidth = screenWidth * 0.32; // ✅ ลดขนาดเพื่อให้ใกล้กันมากขึ้น
  double posterHeight = posterWidth * 1.5;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.34, // ✅ ลดระยะห่าง (ยิ่งน้อย ยิ่งติดกัน)
          enableInfiniteScroll: true,
          height: posterHeight + 50,
        ),
        items: movies.map((movie) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4), // ✅ ลด Padding ให้รูปติดกันมากขึ้น
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailScreen(
                      title: movie['title'],
                      genre: movie['genres'].join(', '),
                      duration: movie['date'],
                      posterPath: movie['poster'],
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      movie['poster'],
                      width: posterWidth,
                      height: posterHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: posterWidth,
                    child: Text(
                      movie['title'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(movie['date'], style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

















Widget discountList(BuildContext context, List<Map<String, String>> discounts) {
  double screenWidth = MediaQuery.of(context).size.width;
  double imageSize = screenWidth * 0.22;
  double containerWidth = screenWidth * 0.85;
  double fontSizeTitle = screenWidth * 0.04;
  double fontSizeSub = screenWidth * 0.03;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Discounts",
              style: TextStyle(
                fontSize: fontSizeTitle,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
  onTap: () {
    // ✅ เปลี่ยน tab ไปที่ DiscountsScreen ใน MainScreen
    MainScreen.of(context)?.changeTab(3);
  },
  child: Text(
    "View All",
    style: TextStyle(
      fontSize: fontSizeSub,
      fontWeight: FontWeight.bold,
      color: Colors.yellow,
    ),
  ),
),

          ],
        ),
      ),
      SizedBox(height: screenWidth * 0.02),
      CarouselSlider.builder(
        options: CarouselOptions(
          height: screenWidth * 0.3,
          enableInfiniteScroll: true,
          viewportFraction: 0.9,
          enlargeCenterPage: false,
        ),
        itemCount: discounts.length,
        itemBuilder: (context, index, realIndex) {
          final discount = discounts[index];
          return ClipPath(
            clipper: TicketClipper(),
            child: Container(
              width: containerWidth,
              decoration: BoxDecoration(
                color: Color(0xFF222222),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.02),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      discount['image']!,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/major_logo_mini.jpg",
                            width: screenWidth * 0.07,
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            discount['title']!,
                            style: TextStyle(
                              fontSize: fontSizeTitle,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            discount['validity']!,
                            style: TextStyle(
                              fontSize: fontSizeSub,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}












  Widget technologyGrid(List<Map<String, String>> technologies) {
  double screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth > 600 ? 5 : 4, // ✅ ปรับจำนวนคอลัมน์ตามจอ
        childAspectRatio: 1,
      ),
      itemCount: technologies.length,
      itemBuilder: (context, index) {
        final technology = technologies[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            technology['image']!,
            width: screenWidth * 0.18, // ✅ ปรับขนาดรูปอัตโนมัติ
            height: screenWidth * 0.18,
            fit: BoxFit.contain,
          ),
        );
      },
    ),
  );
}


  
}
// CustomClipper สำหรับทำจุดเว้า
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // สร้างกรอบหลักของบัตร
    path.addRRect(RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ));

    // จุดเว้าซ้าย
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.25, 0), radius: 10));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.25, size.height), radius: 10));

    // จุดเว้าขวา
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.75, 0), radius: 10));
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.75, size.height), radius: 10));

    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => false;
}