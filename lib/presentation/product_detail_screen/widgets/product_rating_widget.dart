import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProductRatingWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const ProductRatingWidget({
    Key? key,
    required this.rating,
    this.reviewCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Star Rating
        ...List.generate(5, (index) {
          return Container(
            margin: EdgeInsets.only(right: 1.w),
            child: Icon(
              index < rating.floor() ? Icons.star : Icons.star_border,
              color:
                  index < rating.floor() ? Colors.orange : Colors.grey.shade400,
              size: 5.w,
            ),
          );
        }),

        SizedBox(width: 2.w),

        // Rating Text
        Text(
          rating.toString(),
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Review Count (if provided)
        if (reviewCount > 0) ...[
          SizedBox(width: 2.w),
          Text(
            '($reviewCount reviews)',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
