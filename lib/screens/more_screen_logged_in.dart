import 'package:flutter/material.dart';

class MoreScreenLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('My Account', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Discount'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuItem(Icons.person, 'Profile Detail'),
            _buildMenuItem(Icons.confirmation_number, 'Ticket History'),
            _buildMenuItem(Icons.credit_card, 'Saved Card'),
            _buildMenuItem(Icons.star, 'Watchlist'),
            _buildMenuItem(Icons.history, 'Transaction History'),
            _buildMenuItem(Icons.language, 'Language', trailing: Text('ไทย | ENG', style: TextStyle(color: Colors.amber))),
            _buildMenuItem(Icons.phone, 'Contact Us'),
            _buildMenuItem(Icons.help_outline, 'FAQ'),
            _buildMenuItem(Icons.logout, 'Logout', iconColor: Colors.red, textColor: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, {Widget? trailing, Color iconColor = Colors.amber, Color textColor = Colors.white}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
      trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {},
    );
  }
}