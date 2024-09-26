import 'package:flutter/material.dart';
import 'package:my_status_widget/my_status_widget.dart';

/// A simple Flutter application to demonstrate the use of StatusDottedBordersWidget.
void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Dotted Borders Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Status Dotted Borders Example'),
        ),
        body: Center(
          child: SizedBox(
            width: 100, // Width of the dotted border widget
            height: 100, // Height of the dotted border widget
            child: CustomPaint(
              painter: StatusDottedBordersWidget(
                numberOfStories: 5, // Number of stories to display
                isMe:
                    false, // Indicates whether the stories belong to the current user
                images: [
                  'uid1',
                  'uid2',
                  'uid3',
                  'uid4',
                  'uid5'
                ], // List of user IDs for the stories
                uid: 'uid1', // ID of the current user
              ),
            ),
          ),
        ),
      ),
    );
  }
}
