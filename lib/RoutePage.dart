import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'Journey.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final ImagePicker _picker = ImagePicker();
  final List<Position> _path = <Position>[];
  XFile? _image;
  late StreamSubscription<Position> _positionStreamSubscription;

  void _startTracking() {
    _positionStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      if (mounted) {
        setState(() {
          _path.add(position);
        });
      }
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (mounted) {
        setState(() {
          _image = image;
        });
      }
    }
  }

  void _endJourney(String title) {
    _positionStreamSubscription.cancel();
    Navigator.pop(
      context,
      Journey(
        title: title,
        image: _image?.path,
        path: _path,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String? _journeyTitle;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Page'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Journey Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _journeyTitle = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _startTracking,
                child: const Text('Start Tracking'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _endJourney(_journeyTitle!);
                  }
                },
                child: const Text('End Journey'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
