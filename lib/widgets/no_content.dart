import 'package:flutter/material.dart';

class NoContent extends StatelessWidget {
  const NoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.grey[100],
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off, size: 60, color: Colors.blueAccent),
              SizedBox(height: 16),
              Text("No Records Found",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("There are currently no records available",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
