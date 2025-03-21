import 'package:flutter/material.dart';
import 'package:major_app/screens/login_screen.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('assets/images/major_logo.png', height: 80, width: 80),

        centerTitle: true,
        titleSpacing: 0, // ปรับการจัดระยะของ title
        toolbarHeight: 100, // ปรับความสูงของ AppBar
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enjoy an exclusive, new cinema experience.',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Divider(color: Colors.amber, thickness: 2),
            SizedBox(height: 8),
            Text(
              'Create an account now to enjoy even more.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.amber,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    minimumSize: Size(double.infinity, 50),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(), // 👈 ไปหน้า LoginScreen
      ),
    );
  },
  child: Text(
    'Login / Sign up',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
  ),
),

            SizedBox(height: 16),
            _buildOption(Icons.star_border, 'Watchlist'),
            _buildOption(Icons.language, 'Language', trailing: Text('ไทย | ENG', style: TextStyle(color: Colors.amber))),
            _buildOption(Icons.phone, 'Contact Us'),
            _buildOption(Icons.help_outline, 'FAQ'),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, {Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.white),
      onTap: () {},
    );
  }
}
