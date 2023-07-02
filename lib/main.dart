import 'package:flutter/material.dart';
import 'Route.dart';
import 'Journey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journey App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Main Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Journey> _journeys =
      <Journey>[]; // Replace Journey with your Journey model

  void _startJourney() async {
    final Journey? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RoutePage()),
    );

    if (result != null) {
      setState(() {
        _journeys.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _journeys.length,
        itemBuilder: (context, index) {
          final Journey journey = _journeys[index];
          return ListTile(
            leading: journey.image != null
                ? Image.network(journey.image ??
                    'https://frogdesign.nyc3.cdn.digitaloceanspaces.com/wp-content/uploads/2021/08/30143009/21_Case-Study-BRP-01.jpg')
                : const Icon(Icons.image_not_supported),
            title: Text(journey.title),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startJourney,
        tooltip: 'Start Journey',
        child: const Icon(Icons.add),
      ),
    );
  }
}
