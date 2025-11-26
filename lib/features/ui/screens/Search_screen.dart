import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const SearchScreen({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Search Page', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
