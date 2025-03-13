import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildShimmerCard(),
        const SizedBox(height: 16),
        _buildShimmerCard(height: 10, width: 200),
        _buildShimmerCard(height: 10, width: 100),
        _buildShimmerCard(height: 10, width: 150),
      ],
    );
  }
}

Widget _buildShimmerCard(
    {double? height = 100, double? width = double.infinity}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(height: height, width: width),
    ),
  );
}
