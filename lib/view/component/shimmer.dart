import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadShimmer extends StatelessWidget {
  final double width;
  final double height;

  const LoadShimmer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: width,
            height: height,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
