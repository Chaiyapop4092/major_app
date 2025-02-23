import 'package:flutter/material.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool isGridView = true; // To toggle between grid views

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Movies', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              isGridView ? Icons.grid_on : Icons.view_list, // Toggle between grid and list icon
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isGridView = !isGridView; // Toggle the view
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Gifts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        'Now Showing',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        'Coming Soon',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        'Watchlist',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('IMAX', style: TextStyle(color: Colors.white)),
                  Text('4DX', style: TextStyle(color: Colors.white)),
                  Text('Screen X', style: TextStyle(color: Colors.white)),
                  Text('LED', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: isGridView
                  ? GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: 3, // You can dynamically adjust the number of movies
                      itemBuilder: (context, index) {
                        return MovieCard(
                          title: 'Movie $index',
                          releaseDate: 'Release Date',
                          genres: ['Genre 1', 'Genre 2'],
                          imageUrl: 'assets/movie_image.jpg',
                        );
                      },
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      children: [
                        MovieCard(
                          title: 'Den of Thieves Pantera',
                          releaseDate: '20 Feb 2025',
                          genres: ['Crime', 'Drama'],
                          imageUrl: 'assets/den_of_thieves.jpg',
                        ),
                        MovieCard(
                          title: 'Avengers: Endgame',
                          releaseDate: '26 Apr 2019',
                          genres: ['Action', 'Sci-Fi'],
                          imageUrl: 'assets/avengers_endgame.jpg',
                        ),
                        MovieCard(
                          title: 'The Batman',
                          releaseDate: '4 Mar 2022',
                          genres: ['Action', 'Crime'],
                          imageUrl: 'assets/the_batman.jpg',
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageUrl),
        SizedBox(height: 8),
        Text(
          releaseDate,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: genres.map((genre) => Padding(
            padding: EdgeInsets.only(right: 8),
            child: Chip(
              backgroundColor: Colors.grey[800],
              label: Text(
                genre,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
