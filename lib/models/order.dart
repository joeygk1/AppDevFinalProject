import 'sneaker.dart';

class Order {
  final String id;
  final String userId;
  final String title;
  final String brand;
  final String image;
  final double minPrice;
  final DateTime orderDate;
  final String status;

  Order({
    required this.id,
    required this.userId,
    required this.title,
    required this.brand,
    required this.image,
    required this.minPrice,
    required this.orderDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'brand': brand,
      'image': image,
      'minPrice': minPrice,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      brand: json['brand'],
      image: json['image'],
      minPrice: json['minPrice'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
    );
  }
} 