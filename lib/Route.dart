import 'package:flutter/material.dart';
import 'main.dart';
import 'Journey.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, Journey(title: 'Journey Title', image: 'https://example.com/image.png'));
          },
          child: const Text('End Journey'),
        ),
      ),
    );
  }
}
