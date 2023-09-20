import 'package:flutter/material.dart';

class UpwardSlopedCircularContainer extends StatelessWidget {
  final double angle; // Eğim açısı (derece cinsinden)
  final double height; // Boyut
  final double width;
  final double opacity; // Opaklık

  UpwardSlopedCircularContainer({
    required this.angle,
    required this.height,
    required this.width,
    this.opacity = 0.3, // Varsayılan opaklık değeri 1.0 (tamamen opak)
  });

  @override
  Widget build(BuildContext context) {
    // Eğim açısını radyan cinsinden hesaplayın
    double radians = angle * (3.14159265359 / 180);

    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // Yukarıdan basık yapmak için perspektif ayarı
        ..rotateX(-radians), // X ekseni etrafında eğim
      alignment: Alignment.center,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Center(
           
          ),
        ),
      ),
    );
  }
}
