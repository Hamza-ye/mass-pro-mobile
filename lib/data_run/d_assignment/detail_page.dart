import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.category, super.key});
  
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Details')),
      body: Center(
        child: Text('Showing details for $category assignments.'),
      ),
    );
  }
}
