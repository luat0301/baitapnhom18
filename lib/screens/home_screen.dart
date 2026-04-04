import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  String selectedCategory = 'Tất cả';

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Rau muống',
      'price': '10.000đ',
      'category': 'Rau',
      'icon': Icons.eco,
    },
    {
      'name': 'Cà rốt',
      'price': '15.000đ',
      'category': 'Củ',
      'icon': Icons.spa,
    },
    {
      'name': 'Táo',
      'price': '25.000đ',
      'category': 'Quả',
      'icon': Icons.apple,
    },
    {
      'name': 'Cải xanh',
      'price': '12.000đ',
      'category': 'Rau',
      'icon': Icons.eco_outlined,
    },
    {
      'name': 'Khoai tây',
      'price': '18.000đ',
      'category': 'Củ',
      'icon': Icons.circle_outlined,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    final keyword = _searchController.text.trim().toLowerCase();

    return products.where((product) {
      final matchCategory = selectedCategory == 'Tất cả'
          ? true
          : product['category'] == selectedCategory;

      final matchKeyword =
      product['name'].toString().toLowerCase().contains(keyword);

      return matchCategory && matchKeyword;
    }).toList();
  }

  Widget _buildCategoryButton(String title) {
    final isSelected = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Icon(
              product['icon'],
              size: 38,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Giá: ${product['price']}',
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 6),
                Text(
                  'Loại: ${product['category']}',
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã thêm ${product['name']} vào giỏ hàng')),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 74,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSimpleMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                Border.all(color: Colors.black, width: 2),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                    child: Icon(Icons.search, size: 28),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (_) => setState(() {}),
                                      decoration: const InputDecoration(
                                        hintText: 'Tìm kiếm',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildCategoryButton('Tất cả'),
                                  const SizedBox(width: 10),
                                  _buildCategoryButton('Rau'),
                                  const SizedBox(width: 10),
                                  _buildCategoryButton('Củ'),
                                  const SizedBox(width: 10),
                                  _buildCategoryButton('Quả'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 22),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Xin chào, ${widget.username}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (items.isEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.black, width: 2),
                                ),
                                child: const Text(
                                  'Không tìm thấy sản phẩm',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            else
                              ...items.map(_buildProductCard),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: Row(
                children: [
                  _buildBottomButton(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Giỏ hàng',
                    onTap: () => _showSimpleMessage('Mở giỏ hàng'),
                  ),
                  _buildBottomButton(
                    icon: Icons.history,
                    label: 'Lịch sử mua',
                    onTap: () => _showSimpleMessage('Mở lịch sử mua'),
                  ),
                  _buildBottomButton(
                    icon: Icons.person_outline,
                    label: 'Profile',
                    onTap: () => _showSimpleMessage('Mở trang cá nhân'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}