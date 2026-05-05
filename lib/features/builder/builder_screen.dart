import 'package:flutter/material.dart';

class BuilderScreen extends StatelessWidget {
  final int? buildId;
  const BuilderScreen({super.key, this.buildId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(buildId == null ? 'New Build' : 'Edit Build'),
      ),
      body: const Center(child: Text('Builder — coming soon')),
    );
  }
}
