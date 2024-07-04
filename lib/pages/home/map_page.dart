import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_tales/util/constants.dart';
import 'package:travel_tales/widgets/fields/custom_text_form_field.dart';

import '../../model/post_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<PostModel> postList = [];
  PostModel? selectedPost;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();

    postList.add(PostModel(
      title: "Fatih Camii",
      content: "Çok güzel bir cami.",
      imageUrl:
          "https://gezimanya.com/sites/default/files/styles/800x600_/public/gezilecek-yerler/2019-11/image-fatih3.jpg",
      position: const LatLng(41.0195871, 28.9499335),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double cardHeight = screenWidth * 0.3;
    BorderRadius borderRadius = BorderRadius.circular(Constants.defaultRadius);

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _buildMap(),
          if (selectedPost != null)
            SafeArea(
              child: _buildDetailCard(borderRadius, cardHeight, context),
            ),
        ],
      ),
    );
  }

  Card _buildDetailCard(
    BorderRadius borderRadius,
    double cardHeight,
    BuildContext context,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      margin: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
      child: IntrinsicHeight(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: borderRadius,
              child: Image.network(
                selectedPost!.imageUrl,
                width: cardHeight,
                height: cardHeight,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding / 3),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedPost!.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          selectedPost!.content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF469A88),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.navigation_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GoogleMap _buildMap() {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
      },
      initialCameraPosition:
          CameraPosition(target: LatLng(40.9963991, 28.8329137)),
      zoomControlsEnabled: false,
      myLocationEnabled: false,
      buildingsEnabled: false,
      mapToolbarEnabled: false,
      markers: postList
          .map(
            (post) => Marker(
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              markerId: MarkerId(
                postList.indexOf(post).toString(),
              ),
              position: post.position,
              onTap: () {
                if (_mapController == null) return;
                _mapController!.animateCamera(
                    CameraUpdate.newLatLngZoom(post.position, 15));
                setState(() {
                  selectedPost = post;
                });
              },
            ),
          )
          .toSet(),
      onLongPress: (value) {
        debugPrint("Google Maps Long press");
        showAddPost(value);
      },
      onTap: (position) {
        setState(() {
          selectedPost = null;
        });
      },
    );
  }

  void showAddPost(LatLng position) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        TextEditingController titleController = TextEditingController();
        TextEditingController contentController = TextEditingController();
        TextEditingController imageController = TextEditingController();

        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(Constants.defaultPadding),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextFormField(
                      label: "Başlık",
                      controller: titleController,
                    ),
                    SizedBox(
                      height: Constants.defaultPadding / 3,
                    ),
                    CustomTextFormField(
                      label: "İçerik",
                      controller: contentController,
                    ),
                    SizedBox(
                      height: Constants.defaultPadding / 3,
                    ),
                    CustomTextFormField(
                      label: "Fotoğraf adresi",
                      controller: imageController,
                    ),
                    SizedBox(
                      height: Constants.defaultPadding / 3,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _addPost(
                          position,
                          titleController.text,
                          contentController.text,
                          imageController.text,
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Paylaş"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _addPost(
    LatLng position,
    String title,
    String content,
    String imageUrl,
  ) {
    postList.add(
      PostModel(
        title: title,
        content: content,
        imageUrl: imageUrl,
        position: position,
      ),
    );

    /* markerSet.add(
      Marker(
        markerId: MarkerId(
          markerSet.length.toString(),
        ),
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      ),
    ); */
    setState(() {});
  }
}
