import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Gio hang')),
      body: appState.cart.isEmpty
          ? const Center(child: Text('Chua co san pham trong gio'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: appState.cart.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, index) {
                      final item = appState.cart[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('${item.product.price.toStringAsFixed(0)} đ / ${item.product.unit}'),
                        trailing: SizedBox(
                          width: 140,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => appState.updateCart(item.product, item.quantity - 1),
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                onPressed: () => appState.updateCart(item.product, item.quantity + 1),
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Tong tien: ${appState.cartTotal.toStringAsFixed(0)} đ', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () async {
                          final error = await context.read<AppState>().placeOrder();
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error ?? 'Dat hang thanh cong')),
                          );
                        },
                        child: const Text('Dat hang'),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
