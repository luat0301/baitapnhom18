import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleRegister() async {
    final error = await context.read<AppState>().register(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
          phoneController.text.trim(),
        );
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dang ky thanh cong, hay dang nhap')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AppState>().isLoading;
    return Scaffold(
      appBar: AppBar(title: const Text('Dang ky')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Ho ten', border: OutlineInputBorder())),
                const SizedBox(height: 16),
                TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
                const SizedBox(height: 16),
                TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'So dien thoai', border: OutlineInputBorder())),
                const SizedBox(height: 16),
                TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Mat khau', border: OutlineInputBorder())),
                const SizedBox(height: 16),
                FilledButton(onPressed: loading ? null : handleRegister, child: Text(loading ? 'Dang xu ly...' : 'Dang ky')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
