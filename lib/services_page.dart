import 'package:flutter/material.dart';
import 'widgets.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      'title': 'Sneaker Cleaning',
      'description': 'Professional cleaning service for all types of sneakers',
      'price': '\$30',
      'duration': '24-48 hours',
    },
    {
      'title': 'Sole Restoration',
      'description': 'Restore worn-out soles to their original condition',
      'price': '\$50',
      'duration': '48-72 hours',
    },
    {
      'title': 'Customization',
      'description': 'Custom paint jobs and modifications for your sneakers',
      'price': '\$80',
      'duration': '72-96 hours',
    },
  ];

  Widget _buildServiceCard(Map<String, String> service) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service['title']!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              service['description']!,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      service['price']!,
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Duration',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      service['duration']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement service booking
              },
              child: Text('Book Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sneaker Services'),
        backgroundColor: Colors.grey[900],
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(services[index]);
        },
      ),
    );
  }
}
