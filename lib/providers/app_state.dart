import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class AppState extends ChangeNotifier {
  User? currentUser;
  List<Product> products = [];
  List<CartItem> cart = [];
  List<Order> orders = [];
  List<Order> adminOrders = [];
  bool isLoading = false;

  Future<void> loadSession() async {
    currentUser = await LocalStorageService.getUser();
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.login(email, password);

      if (result['success'] == true) {
        currentUser = User.fromJson(result['user'] as Map<String, dynamic>);
        await LocalStorageService.saveUser(currentUser!);
        isLoading = false;
        notifyListeners();
        return null;
      }

      isLoading = false;
      notifyListeners();
      return result['message']?.toString() ?? 'Đăng nhập thất bại';
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return 'Lỗi: $e';
    }
  }

  Future<String?> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await ApiService.register(name, email, password, phone);
      isLoading = false;
      notifyListeners();

      if (result['success'] == true) {
        return null;
      }

      return result['message']?.toString() ?? 'Đăng ký thất bại';
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return 'Lỗi: $e';
    }
  }

  Future<void> fetchProducts() async {
    try {
      final result = await ApiService.getProducts();

      if (result['success'] == true) {
        products = (result['data'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<String?> addProduct(
    String name,
    double price,
    String category,
  ) async {
    try {
      final result = await ApiService.addProduct(name, price, category);

      if (result['success'] == true) {
        await fetchProducts();
        return null;
      }

      return result['message']?.toString() ?? 'Thêm sản phẩm thất bại';
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  Future<String?> deleteProduct(int id) async {
    try {
      final result = await ApiService.deleteProduct(id);

      if (result['success'] == true) {
        await fetchProducts();
        return null;
      }

      return result['message']?.toString() ?? 'Xóa sản phẩm thất bại';
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  void addToCart(Product product) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      cart[index].quantity += 1;
    } else {
      cart.add(CartItem(product: product, quantity: 1));
    }

    notifyListeners();
  }

  void updateCart(Product product, int quantity) {
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index == -1 && quantity > 0) {
      cart.add(CartItem(product: product, quantity: quantity));
    } else if (index >= 0) {
      if (quantity <= 0) {
        cart.removeAt(index);
      } else {
        cart[index].quantity = quantity;
      }
    }

    notifyListeners();
  }

  void removeFromCart(int productId) {
    cart.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  double get cartTotal {
    return cart.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  Future<String?> placeOrder() async {
    if (currentUser == null) return 'Bạn chưa đăng nhập';
    if (cart.isEmpty) return 'Giỏ hàng trống';

    try {
      final List<Map<String, dynamic>> items = cart
          .map(
            (e) => {
              'product_id': e.product.id,
              'quantity': e.quantity,
              'price': e.product.price,
            },
          )
          .toList();

      final result = await ApiService.createOrder(
        currentUser!.id,
        cartTotal,
        items,
      );

      if (result['success'] == true) {
        clearCart();
        await fetchOrders();
        return null;
      }

      return result['message']?.toString() ?? 'Đặt hàng thất bại';
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  Future<void> fetchOrders() async {
    if (currentUser == null) return;

    try {
      final result = await ApiService.getOrders(currentUser!.id);

      if (result['success'] == true) {
        orders = (result['data'] as List)
            .map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> fetchAdminOrders() async {
    try {
      final result = await ApiService.getAdminOrders();

      if (result['success'] == true) {
        adminOrders = (result['data'] as List)
            .map((e) => Order.fromJson(e as Map<String, dynamic>))
            .toList();
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> logout() async {
    currentUser = null;
    cart.clear();
    orders.clear();
    adminOrders.clear();
    await LocalStorageService.clearUser();
    notifyListeners();
  }
}