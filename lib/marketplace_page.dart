import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Marketplace', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            // Marketplace items
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // Replace with actual items
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Item #${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Price: \$50',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onTap: () {
                    // Navigate to item details page
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
