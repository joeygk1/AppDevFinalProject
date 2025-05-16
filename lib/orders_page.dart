import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'models/order.dart';
import 'widgets.dart';

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
              return buildErrorWidget(
                'Error loading orders',
                onRetry: () => setState(() {}),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildLoadingWidget();
            }

            final orders = snapshot.data?.docs ?? [];

            if (orders.isEmpty) {
              return buildEmptyStateWidget('No orders yet');
            }

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final orderData = orders[index].data() as Map<String, dynamic>;
                
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
                          order.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
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
                        order.title,
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
                            order.brand,
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Ordered on ${order.orderDate.toString().split(' ')[0]}',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${order.minPrice.toStringAsFixed(0)}',
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
