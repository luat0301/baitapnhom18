class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String unit;
  final String imageUrl;
  final int stock;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.imageUrl,
    required this.stock,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0,
      unit: json['unit']?.toString() ?? 'kg',
      imageUrl: json['image_url']?.toString() ?? '',
      stock: int.tryParse(json['stock'].toString()) ?? 0,
      category: json['category']?.toString() ?? '',
    );
  }
}
