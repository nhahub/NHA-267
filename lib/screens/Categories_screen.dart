import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const CategoriesScreen({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Categories Page', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
