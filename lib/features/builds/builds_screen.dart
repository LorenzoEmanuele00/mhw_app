import 'package:flutter/material.dart';

class BuildsScreen extends StatelessWidget {
  const BuildsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Builds')),
      body: const Center(child: Text('Builds — coming soon')),
    );
  }
}
