import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost/backend/api';
    }
    return 'http://10.0.2.2/backend/api';
  }

 static Future<Map<String, dynamic>> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login.php'),
    body: {
      'email': email,
      'password': password,
    },
  );

  debugPrint('LOGIN STATUS: ${response.statusCode}');
  debugPrint('LOGIN BODY: ${response.body}');

  try {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } catch (_) {
    return {
      'success': false,
      'message': 'Server không trả JSON hợp lệ: ${response.body}',
    };
  }
}

static Future<Map<String, dynamic>> register(
  String name,
  String email,
  String password,
  String phone,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/register.php'),
    body: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    },
  );

  debugPrint('REGISTER STATUS: ${response.statusCode}');
  debugPrint('REGISTER BODY: ${response.body}');

  try {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } catch (_) {
    return {
      'success': false,
      'message': 'Server không trả JSON hợp lệ: ${response.body}',
    };
  }
}

  static Future<Map<String, dynamic>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products.php'));
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> addProduct(
    String name,
    double price,
    String category,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_product.php'),
      body: {
        'name': name,
        'price': price.toString(),
        'category': category,
      },
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> deleteProduct(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete_product.php'),
      body: {
        'id': id.toString(),
      },
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

 static Future<Map<String, dynamic>> createOrder(
  int userId,
  double total,
  List<Map<String, dynamic>> items,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/create_order.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_id': userId,
      'total_amount': total,
      'items': items,
    }),
  );

  debugPrint('CREATE ORDER STATUS: ${response.statusCode}');
  debugPrint('CREATE ORDER BODY: ${response.body}');

  try {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } catch (_) {
    return {
      'success': false,
      'message': 'Server không trả JSON hợp lệ: ${response.body}',
    };
  }
}

  static Future<Map<String, dynamic>> getOrders(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/orders.php?user_id=$userId'),
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getAdminOrders() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin_orders.php'),
    );
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}