import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/layout/overlay_top_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "",
        dismissIcon: FluentIcons.chevron_left_12_filled,
      ),
      body: InvertedMountainShape(),
    );
  }
}

class InvertedMountainShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 200),
      painter: InvertedMountainPainter(),
    );
  }
}

class InvertedMountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double controlPointHeight =
        height * 0.3; // Adjust control point height
    final double peakHeight = height * 0.5; // Adjust peak height

    final Paint paint = Paint()
      ..color = Colors.blue; // Customize color as needed

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, peakHeight)
      ..quadraticBezierTo(width / 2, controlPointHeight, width, peakHeight)
      ..lineTo(width, 0)
      ..close();

    final double bumpWidth = width * 0.2; // Adjust bump width
    final double bumpHeight = height * 0.2; // Adjust bump height
    final double bumpStart1 =
        width * 0.3; // Adjust start position of first bump
    final double bumpStart2 =
        width * 0.7; // Adjust start position of second bump

    final Path bump1 = Path()
      ..moveTo(bumpStart1, peakHeight)
      ..quadraticBezierTo(bumpStart1 + bumpWidth / 2, peakHeight + bumpHeight,
          bumpStart1 + bumpWidth, peakHeight)
      ..close();

    final Path bump2 = Path()
      ..moveTo(bumpStart2, peakHeight)
      ..quadraticBezierTo(bumpStart2 + bumpWidth / 2, peakHeight + bumpHeight,
          bumpStart2 + bumpWidth, peakHeight)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(bump1, paint);
    canvas.drawPath(bump2, paint);
  }

  @override
  bool shouldRepaint(InvertedMountainPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(InvertedMountainPainter oldDelegate) => false;
}
