import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostModel {
  PostModel({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.position,
  });

  String title;
  String content;
  String imageUrl;
  LatLng position;
}
