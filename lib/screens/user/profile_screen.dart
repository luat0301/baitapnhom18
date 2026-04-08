import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Tai khoan')),
      body: user == null
          ? const Center(child: Text('Chua dang nhap'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ho ten: ${user.name}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('So dien thoai: ${user.phone}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Vai tro: ${user.role}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () async => context.read<AppState>().logout(),
                    icon: const Icon(Icons.logout),
                    label: const Text('Dang xuat'),
                  ),
                ],
              ),
            ),
    );
  }
}
