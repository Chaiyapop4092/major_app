import 'package:flutter/material.dart';

class DiscountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Discounts', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.asset('assets/images/ads1.jpg'),
            ),
            SizedBox(height: 16),
            Row(
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
                      'Discounts',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      'News',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Enter or scan discount code',
                hintStyle: TextStyle(color: Colors.white60),
                suffixIcon: Icon(Icons.qr_code_scanner, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 8, // Example count
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset('assets/images/payment$index.jpg', fit: BoxFit.cover),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Text(
              'All Discounts',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.amber, fontSize: 16),
              ),
            ),
            
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Example count
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      leading: Image.asset('assets/images/discount$index.jpg'),
                      title: Text('M-Coupon: Discount 50 THB', style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
