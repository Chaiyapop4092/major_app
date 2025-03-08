import 'package:flutter/material.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool isGridView = true; // Toggle between Grid and List View
  bool isNowShowing = true; // Toggle between Now Showing and Coming Soon
  bool isWatchlist = false; // Toggle between Watchlist and Movies

  // Movie List for Now Showing
  final List<Map<String, dynamic>> nowShowingMovies = [
    {
      'title': 'Den of Thieves Pantera',
      'releaseDate': '20 Feb 2025',
      'genres': ['Crime', 'Drama'],
      'imageUrl': 'assets/images/movie1.jpg',
    },
    {
      'title': 'Legends of the City',
      'releaseDate': '26 Apr 2019',
      'genres': ['Drama', 'Action'],
      'imageUrl': 'assets/images/movie2.jpg',
    },
    {
      'title': 'Happy Mondays',
      'releaseDate': '4 Mar 2022',
      'genres': ['Comedy', 'Romance'],
      'imageUrl': 'assets/images/movie3.jpg',
    },
    {
      'title': 'Cleaner',
      'releaseDate': '4 Mar 2022',
      'genres': ['Drama', 'Action'],
      'imageUrl': 'assets/images/movie4.jpg',
    },
    {
      'title': 'Captain America Brave New World',
      'releaseDate': '4 Mar 2022',
      'genres': ['Action', 'Adventure'],
      'imageUrl': 'assets/images/movie5.jpg',
    },
    {
      'title': 'Nosferatu',
      'releaseDate': '4 Mar 2022',
      'genres': ['Drama', 'Horror'],
      'imageUrl': 'assets/images/movie6.jpg',
    },
    {
      'title': 'Attack on Titan: The Last Attack',
      'releaseDate': '4 Mar 2022',
      'genres': ['Drama', 'Action'],
      'imageUrl': 'assets/images/movie7.jpg',
    },
  ];

  // Movie List for Coming Soon
  final List<Map<String, dynamic>> comingSoonMovies = [
    {
      'title': 'Eternal Bond',
      'releaseDate': '20 Mar 2025',
      'genres': ['Thriller'],
      'imageUrl': 'assets/images/coming1.jpg',
    },
    {
      'title': 'Mobile Suit Gundam',
      'releaseDate': '15 Apr 2025',
      'genres': ['Drama', 'Action'],
      'imageUrl': 'assets/images/coming2.jpg',
    },
    {
      'title': 'The Brutalist',
      'releaseDate': '1 May 2025',
      'genres': ['Drama'],
      'imageUrl': 'assets/images/coming3.jpg',
    },
    {
      'title': 'The Monkey',
      'releaseDate': '1 May 2025',
      'genres': ['Horror'],
      'imageUrl': 'assets/images/coming4.jpg',
    },
  ];

  // Movie List for Watchlist (Empty for now)
  final List<Map<String, dynamic>> watchlistMovies = []; // Empty for now

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double childAspectRatio = screenWidth < 600 ? 0.65 : 0.85; // Adjust for larger screens

    // Choose the movie list based on whether "Now Showing" or "Coming Soon" is selected
    final List<Map<String, dynamic>> movieList = isNowShowing
        ? nowShowingMovies
        : (isWatchlist ? watchlistMovies : comingSoonMovies);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          isNowShowing
              ? 'Now Showing'
              : (isWatchlist ? 'Watchlist' : 'Coming Soon'),
          style: TextStyle(color: Colors.white),
        ),
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
                  _buildCategoryButton('Now Showing', isSelected: isNowShowing, onPressed: () {
                    setState(() {
                      isNowShowing = true;
                      isWatchlist = false;
                    });
                  }),
                  SizedBox(width: 10),
                  _buildCategoryButton('Coming Soon', isSelected: !isNowShowing && !isWatchlist, onPressed: () {
                    setState(() {
                      isNowShowing = false;
                      isWatchlist = false;
                    });
                  }),
                  SizedBox(width: 10),
                  _buildCategoryButton('Watchlist', isSelected: isWatchlist, onPressed: () {
                    setState(() {
                      isWatchlist = true;
                      isNowShowing = false;
                    });
                  }),
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
              child: isWatchlist && watchlistMovies.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_border,
                            color: Colors.amber,
                            size: 100, // Large star icon
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your watchlist is empty',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Explore more movies. Once you add a movie to the watchlist, you will find it here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : (isGridView
                      ? GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenWidth < 600 ? 2 : 3,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: movieList.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              title: movieList[index]['title'],
                              releaseDate: movieList[index]['releaseDate'],
                              genres: movieList[index]['genres'],
                              imageUrl: movieList[index]['imageUrl'],
                            );
                          },
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: movieList.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              title: movieList[index]['title'],
                              releaseDate: movieList[index]['releaseDate'],
                              genres: movieList[index]['genres'],
                              imageUrl: movieList[index]['imageUrl'],
                            );
                          },
                        )),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Category Buttons
  Widget _buildCategoryButton(String text, {bool isSelected = false, required VoidCallback onPressed}) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
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
            overflow: TextOverflow.ellipsis, // ✅ Handle overflow for title
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
