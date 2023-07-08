import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/common/constant.dart';
import 'package:free_flow/state/gallery.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  final double size = 90;

  @override
  State<StatefulWidget> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int _selectedIndex = -1;

  void _onExpansionChanged(bool isOpen, int index) {
    setState(() => _selectedIndex = isOpen ? index : -1);
  }

  Future _onPhotoTapped(Uint8List photo) {
    return Navigator.pushNamed(context, Nav.viewPhoto, arguments: photo);
  }

  @override
  void initState() {
    super.initState();
    final Future future = context.read<GalleryState>().fetchLastMonth();
    future.then((_) => _onExpansionChanged(true, 0));
  }

  @override
  Widget build(BuildContext context) {
    GalleryState state = context.watch();

    return Scaffold(
      appBar: AppBar(title: const Text("Gallery")),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: ListView.builder(
        key: Key(_selectedIndex.toString()),
        itemCount: state.availableMonths.length,
        itemBuilder: (context, i) {
          final String month = state.getDisplayMonth(i);
          final List<Uint8List> photos = state.getPhotoGroup(month);
          return ExpansionTile(
            initiallyExpanded: _selectedIndex == i,
            expandedAlignment: Alignment.topLeft,
            backgroundColor: Theme.of(context).focusColor,
            childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
            onExpansionChanged: (isOpen) => photos.isEmpty
                ? state.findByMonth(state.availableMonths[i])
                : _onExpansionChanged(isOpen, i),
            title: Text(
              month,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: photos.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8),
                itemBuilder: (context, j) => InkWell(
                  onTap: () => _onPhotoTapped(photos[j]),
                  child: Image.memory(photos[j], fit: BoxFit.cover),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
