import 'package:flutter/material.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool isGridView = true; // Toggle between Grid and List View

  // Movie List (Used for both Grid and List)
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Den of Thieves Pantera',
      'releaseDate': '20 Feb 2025',
      'genres': ['Crime', 'Drama'],
      'imageUrl': 'assets/images/movie1.jpg',
    },
    {
      'title': 'Avengers: Endgame',
      'releaseDate': '26 Apr 2019',
      'genres': ['Action', 'Sci-Fi'],
      'imageUrl': 'assets/images/movie2.jpg',
    },
    {
      'title': 'The Batman',
      'releaseDate': '4 Mar 2022',
      'genres': ['Action', 'Crime'],
      'imageUrl': 'assets/images/movie3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double childAspectRatio = screenWidth < 600 ? 0.65 : 0.85; // Adjust for larger screens

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Movies', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              isGridView ? Icons.grid_on : Icons.grid_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Categories: Now Showing, Coming Soon, Watchlist
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildCategoryButton('Now Showing', isSelected: true),
                  SizedBox(width: 10),
                  _buildCategoryButton('Coming Soon'),
                  SizedBox(width: 10),
                  _buildCategoryButton('Watchlist'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Movie Types: IMAX, 4DX, Screen X, LED
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMovieType('IMAX'),
                  _buildMovieType('4DX'),
                  _buildMovieType('Screen X'),
                  _buildMovieType('LED'),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Movie List/Grid (Use Flexible to prevent overflow)
            Expanded(
              child: isGridView
                  ? GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenWidth < 600 ? 2 : 3,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          title: movies[index]['title'],
                          releaseDate: movies[index]['releaseDate'],
                          genres: movies[index]['genres'],
                          imageUrl: movies[index]['imageUrl'],
                        );
                      },
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return MovieCard(
                          title: movies[index]['title'],
                          releaseDate: movies[index]['releaseDate'],
                          genres: movies[index]['genres'],
                          imageUrl: movies[index]['imageUrl'],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Category Buttons
  Widget _buildCategoryButton(String text, {bool isSelected = false}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  // Helper Widget: Movie Type Tags
  Widget _buildMovieType(String text) {
    return Text(text, style: TextStyle(color: Colors.white));
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String releaseDate;
  final List<String> genres;
  final String imageUrl;

  MovieCard({
    required this.title,
    required this.releaseDate,
    required this.genres,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 **Fixed Image Height for Consistency**
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 200, // ✅ Set a fixed height
              fit: BoxFit.cover, // ✅ Ensures image covers space properly
            ),
          ),
          SizedBox(height: 8),
          Text(
            releaseDate,
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Wrap(
            spacing: 6,
            children: genres.map((genre) {
              return Chip(
                backgroundColor: Colors.grey[800],
                label: Text(
                  genre,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
