class Order {
  final int id;
  final int userId;
  final String customerName;
  final String address;
  final String productsText;
  final double totalAmount;
  final String status;
  final String createdAt;

  Order({
    required this.id,
    required this.userId,
    required this.customerName,
    required this.address,
    required this.productsText,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: int.tryParse(json['id'].toString()) ?? 0,
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      customerName: (json['customer_name'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      productsText: (json['products_text'] ?? '').toString(),
      totalAmount: double.tryParse(json['total_amount'].toString()) ?? 0,
      status: (json['status'] ?? '').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
    );
  }
}