import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/model/photo.dart';

class PhotoSlider extends StatefulWidget {
  const PhotoSlider(this.photos, {super.key});

  final List<Photo> photos;

  @override
  State<StatefulWidget> createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  final CarouselController _controller = CarouselController();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            enlargeCenterPage: true,
            onPageChanged: (index, _) => setState(() => _page = index),
          ),
          items: widget.photos
              .map((photo) => ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Image.memory(
                      photo.content,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.photos.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Colors.black.withOpacity(_page == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
