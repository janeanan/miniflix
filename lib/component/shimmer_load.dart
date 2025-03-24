import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoad extends StatelessWidget {
  final double? height;
  final double? width;
  const ShimmerLoad({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            height: height ?? 14,
            width: width?? 100,
            color: Colors.grey.shade300,
          ),
        ));
  }
}
