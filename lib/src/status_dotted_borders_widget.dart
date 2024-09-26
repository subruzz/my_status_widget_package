import 'dart:math';
import 'package:flutter/material.dart';

/// A custom painter that draws dotted borders representing user stories.
///
/// This widget is designed to visually indicate multiple user stories with
/// circular arcs, providing feedback on whether a user has seen the stories.
/// 
/// The arcs are drawn based on the number of stories and can change color
/// depending on whether the user is the owner of the stories or a viewer.
class StatusDottedBordersWidget extends CustomPainter {
  /// The number of stories to display.
  final int numberOfStories;

  /// The length of the space between story arcs in degrees.
  final int spaceLength;

  /// The unique identifier of the current user.
  final String? uid;

  /// A list of image identifiers or URLs for the stories.
  final List<String>? images;

  /// A boolean indicating whether the current user is the owner of the stories.
  final bool isMe;

  /// A boolean indicating whether the stories are currently loading.
  final bool isLoading;

  /// The starting angle of the arc in degrees.
  double startOfArcInDegree = 0;

  /// Creates an instance of [StatusDottedBordersWidget].
  ///
  /// The [numberOfStories] parameter is required and specifies how many stories
  /// to draw. The [spaceLength] can be adjusted to control the spacing between
  /// arcs. Other parameters control the appearance based on user identity and
  /// loading state.
  StatusDottedBordersWidget({
    required this.numberOfStories,
    this.spaceLength = 10,
    this.isLoading = false,
    this.uid,
    this.images,
    required this.isMe,
  });

  /// Converts degrees to radians.
  ///
  /// This method is used for converting angle measurements from degrees to
  /// radians, which are required for drawing arcs.
  double inRads(double degree) {
    return (degree * pi) / 180;
  }

  /// Determines whether the current painter should repaint.
  ///
  /// Always returns true, indicating that the widget should repaint whenever
  /// its parent rebuilds. For more efficient painting, consider implementing
  /// a more granular comparison based on specific property changes.
  @override
  bool shouldRepaint(StatusDottedBordersWidget oldDelegate) {
    return true;
  }

  /// Paints the arcs on the canvas.
  ///
  /// The arcs are drawn based on the number of stories. If there's only one
  /// story or if the user is the owner, a full circle is drawn. Otherwise,
  /// multiple arcs are drawn with spacing defined by [spaceLength].
  @override
  void paint(Canvas canvas, Size size) {
    if (numberOfStories <= 0) return;

    // Define the rectangle for drawing arcs.
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Check if there's only one story or if the user is the owner.
    if (numberOfStories <= 1 || isMe) {
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        min(size.width / 2, size.height / 2),
        Paint()
          ..color = isMe
              ? (images!.isEmpty ? Colors.grey : Colors.blue)
              : (images!.isNotEmpty && images![0].contains(uid!)
                  ? Colors.grey.withOpacity(.5)
                  : Colors.blue)
          ..strokeWidth = 6
          ..style = PaintingStyle.stroke,
      );
    } else {
      // Calculate the length of each arc.
      double arcLength = (360 - (numberOfStories * spaceLength)) / numberOfStories;

      // Ensure arcLength is not negative.
      if (arcLength <= 0) {
        arcLength = 360 / spaceLength - 1;
      }

      // Draw each story arc.
      for (int i = 0; i < numberOfStories; i++) {
        canvas.drawArc(
          rect,
          inRads(startOfArcInDegree),
          inRads(isLoading ? 0 : arcLength),
          false,
          Paint()
            ..color = isMe
                ? Colors.blue
                : (images![i].contains(uid!)
                    ? Colors.grey.withOpacity(.6)
                    : Colors.blue)
            ..strokeWidth = 6
            ..style = PaintingStyle.stroke,
        );

        // Update the starting angle for the next arc.
        startOfArcInDegree += arcLength + spaceLength;
      }
    }
  }
}
