import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'models/order.dart';

class OrdersPage extends StatefulWidget {
  final String userEmail;

  const OrdersPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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
        child: StreamBuilder<firestore.QuerySnapshot>(
          stream: firestore.FirebaseFirestore.instance
              .collection('orders')
              .where('userId', isEqualTo: widget.userEmail)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error loading orders: ${snapshot.error}');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error loading orders',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {}); // Refresh the page
                      },
                      child: Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              );
            }

            final orders = snapshot.data?.docs ?? [];
            print('Number of orders found: ${orders.length}');
            print('User email: ${widget.userEmail}');

            if (orders.isEmpty) {
              return Center(
        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
          children: [
                    Text(
                      'No orders yet',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your orders will appear here',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final orderData = orders[index].data() as Map<String, dynamic>;
                print('Order data: $orderData');
                
                try {
                  final order = Order.fromJson(orderData);
                  return Card(
                    color: Colors.grey[900],
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          order.sneaker.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('Error loading image: $error');
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[800],
                              child: Icon(Icons.image_not_supported, color: Colors.white),
                            );
                          },
                        ),
                      ),
                  title: Text(
                        order.sneaker.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text(
                            'Ordered on ${order.orderDate.toString().split(' ')[0]}',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${order.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                  ),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          order.status,
                          style: TextStyle(
                    color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ),
                  );
                } catch (e) {
                  print('Error parsing order: $e');
                  return Card(
                    color: Colors.grey[900],
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(
                        'Error loading order',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
                  },
                );
              },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
