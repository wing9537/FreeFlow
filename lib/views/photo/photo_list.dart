import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_flow/state/photo.dart';
import 'package:free_flow/widgets/bottom_nav_bar.dart';
import 'package:free_flow/service/photo.dart';
import 'package:provider/provider.dart';

class PhotoList extends StatefulWidget {
  const PhotoList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  final PhotoService _photoService = PhotoService();
  List<bool> _isExpandedList = [];

  @override
  void initState() {
    super.initState();
    context.read<PhotoState>().getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    PhotoState state = context.watch<PhotoState>();

    // Initialize the isExpandedList with the same length as the number of months
    if (_isExpandedList.isEmpty) {
      _isExpandedList = List<bool>.filled(state.photoMap.length, false);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PhotoList",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          int crossAxisCount = (screenWidth ~/ 120).clamp(2, 5); // 計算每行顯示的縮圖數量，最少2個，最多5個

          return ListView.builder(
            itemCount: state.photoMap.length,
            itemBuilder: (context, monthIndex) {
              String month = state.photoMap.keys.elementAt(monthIndex);
              List<Uint8List>? photos = state.photoMap[month];

              return ExpansionPanelList(
                elevation: 1,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (panelIndex, isExpanded) async {
                  setState(() {
                    _isExpandedList[monthIndex] = !isExpanded;
                  });

                  if (!isExpanded && photos == null) {
                    await context.read<PhotoState>().loadPhotosForMonth(month);
                  }
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          month,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                    body: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: photos?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, photoIndex) {
                        Uint8List photo = photos![photoIndex];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenPhotoViewer(photo: photo),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.memory(
                              photo,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    isExpanded: _isExpandedList[monthIndex],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class FullScreenPhotoViewer extends StatelessWidget {
  final Uint8List photo;

  const FullScreenPhotoViewer({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Image.memory(photo),
      ),
    );
  }
}