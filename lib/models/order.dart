import 'sneaker.dart';

class Order {
  final String id;
  final String userId;
  final Sneaker sneaker;
  final double price;
  final DateTime orderDate;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.sneaker,
    required this.price,
    required this.orderDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'sneaker': {
        'id': sneaker.id,
        'title': sneaker.title,
        'brand': sneaker.brand,
        'image': sneaker.image,
        'sku': sneaker.sku,
      },
      'price': price,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      sneaker: Sneaker.fromJson(json['sneaker']),
      price: json['price'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
    );
  }
} 