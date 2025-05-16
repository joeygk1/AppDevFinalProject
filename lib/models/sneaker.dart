class Sneaker {
  final String id;
  final String title;
  final String brand;
  final String model;
  final String description;
  final String image;
  final String sku;
  final String slug;
  final String category;
  final String secondaryCategory;
  final bool upcoming;
  final String link;
  final double minPrice;
  final double avgPrice;
  final double maxPrice;
  final int rank;
  final int weeklyOrders;
  final List<Map<String, dynamic>> traits;
  final List<Map<String, dynamic>> variants;

  Sneaker({
    required this.id,
    required this.title,
    required this.brand,
    required this.model,
    required this.description,
    required this.image,
    required this.sku,
    required this.slug,
    required this.category,
    required this.secondaryCategory,
    required this.upcoming,
    required this.link,
    required this.minPrice,
    required this.avgPrice,
    required this.maxPrice,
    required this.rank,
    required this.weeklyOrders,
    required this.traits,
    required this.variants,
  });

  factory Sneaker.fromJson(Map<String, dynamic> json) {
    return Sneaker(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      sku: json['sku'] ?? '',
      slug: json['slug'] ?? '',
      category: json['category'] ?? '',
      secondaryCategory: json['secondary_category'] ?? '',
      upcoming: json['upcoming'] ?? false,
      link: json['link'] ?? '',
      minPrice: (json['min_price'] ?? 0).toDouble(),
      avgPrice: (json['avg_price'] ?? 0).toDouble(),
      maxPrice: (json['max_price'] ?? 0).toDouble(),
      rank: json['rank'] ?? 0,
      weeklyOrders: json['weekly_orders'] ?? 0,
      traits: List<Map<String, dynamic>>.from(json['traits'] ?? []),
      variants: List<Map<String, dynamic>>.from(json['variants'] ?? []),
    );
  }

  String get releaseDate {
    final releaseDateTrait = traits.firstWhere(
      (trait) => trait['trait'] == 'Release Date',
      orElse: () => {'value': 'N/A'},
    );
    return releaseDateTrait['value'] ?? 'N/A';
  }

  String get colorway {
    final colorwayTrait = traits.firstWhere(
      (trait) => trait['trait'] == 'Colorway',
      orElse: () => {'value': ''},
    );
    return colorwayTrait['value'] ?? '';
  }
} 