import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Services', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            // List of services
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // Replace with actual services
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Service #${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Description of the service',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onTap: () {
                    // Navigate to service details page
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
