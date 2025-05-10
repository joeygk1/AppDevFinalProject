import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Orders', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            // Mock orders list
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // Replace with actual data
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Order #${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Status: In Progress',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onTap: () {
                    // Navigate to order details page
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
