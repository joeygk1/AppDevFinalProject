import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/sneaker.dart';
import 'widgets.dart';

class SneakerDetailsPage extends StatelessWidget {
  final Sneaker sneaker;
  final String userEmail;

  const SneakerDetailsPage({
    Key? key, 
    required this.sneaker,
    required this.userEmail,
  }) : super(key: key);

  Future<void> _handleBuy(BuildContext context) async {
    try {
      // Create a new order document
      final orderRef = FirebaseFirestore.instance.collection('orders').doc();
      
      // Create the order data with all relevant sneaker details
      final orderData = {
        'id': orderRef.id,
        'userId': userEmail,
        'sneaker': {
          'id': sneaker.id,
          'title': sneaker.title,
          'brand': sneaker.brand,
          'image': sneaker.image,
          'sku': sneaker.sku,
          'description': sneaker.description,
          'releaseDate': sneaker.releaseDate,
          'colorway': sneaker.colorway,
          'category': sneaker.category,
          'minPrice': sneaker.minPrice,
          'maxPrice': sneaker.maxPrice,
          'avgPrice': sneaker.avgPrice,
          'weeklyOrders': sneaker.weeklyOrders,
        },
        'price': sneaker.avgPrice,
        'orderDate': DateTime.now().toIso8601String(),
        'status': 'pending',
      };

      // Save the order to Firestore
      await orderRef.set(orderData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order placed successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to marketplace
      Navigator.pop(context);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error placing order: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                sneaker.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: Icon(Icons.image_not_supported, color: Colors.white, size: 50),
                  );
                },
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Brand
                  Text(
                    sneaker.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    sneaker.brand,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Price Card
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Price',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${sneaker.avgPrice.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Description
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    sneaker.description,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
                  // Details
                  Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow('Style', sneaker.sku),
                  _buildDetailRow('Release Date', sneaker.releaseDate),
                  _buildDetailRow('Colorway', sneaker.colorway),
                  _buildDetailRow('Category', sneaker.category),
                  SizedBox(height: 24),
                  // Market Stats
                  Text(
                    'Market Stats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildMarketStat('Lowest Ask', '\$${sneaker.minPrice.toStringAsFixed(0)}'),
                  _buildMarketStat('Highest Bid', '\$${sneaker.maxPrice.toStringAsFixed(0)}'),
                  _buildMarketStat('Weekly Orders', sneaker.weeklyOrders.toString()),
                  SizedBox(height: 32),
                  // Buy Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _handleBuy(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketStat(String label, String value) {
    return _buildDetailRow(label, value);
  }
} 