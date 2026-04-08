import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController(text: 'admin@vegshop.com');
  final passwordController = TextEditingController(text: '123456');

  Future<void> handleLogin() async {
    final error = await context.read<AppState>().login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AppState>().isLoading;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.eco, size: 60, color: Colors.green),
                    const SizedBox(height: 12),
                    const Text('Dang nhap', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
                    const SizedBox(height: 16),
                    TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Mat khau', border: OutlineInputBorder())),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: loading ? null : handleLogin,
                      child: Text(loading ? 'Dang xu ly...' : 'Dang nhap'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      child: const Text('Chua co tai khoan? Dang ky'),
                    ),
                    const SizedBox(height: 8),
                    const Text('Admin mau: admin@vegshop.com / 123456', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
