import 'package:geolocator/geolocator.dart';


class Journey {
  Journey({
    required this.title,
    this.image,
    required this.path,
  });

  final String title;
  final String? image;
  final List<Position> path;
}
