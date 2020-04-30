import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String image;
  final double imageSize;
  final double whiteMargin;
  final double imageMargin;

  CircleImage(
    this.image, {
    this.imageSize = 70.0,
    this.whiteMargin = 2.5,
    this.imageMargin = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.imageSize,
      width: this.imageSize,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            Colors.cyan,
            Colors.red,
            Colors.amber,
            Colors.grey,
            Colors.green,
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: FittedBox(
          child: Container(
            margin: EdgeInsets.all(4.0),
            height: 90.0,
            width: 90.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
