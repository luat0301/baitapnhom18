import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AppState>().fetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<AppState>().orders;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F2),
      appBar: AppBar(
        title: const Text('Đơn hàng'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: context.read<AppState>().fetchOrders,
        child: orders.isEmpty
            ? const Center(
                child: Text(
                  'Chưa có đơn hàng nào',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đơn #${order.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Sản phẩm: ${order.productsText}'),
                        const SizedBox(height: 6),
                        Text(
                          'Tổng tiền: ${order.totalAmount.toStringAsFixed(0)}đ',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text('Trạng thái: ${order.status}'),
                        const SizedBox(height: 6),
                        Text('Ngày tạo: ${order.createdAt}'),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}