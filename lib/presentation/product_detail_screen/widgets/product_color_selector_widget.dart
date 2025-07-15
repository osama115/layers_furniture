import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProductColorSelectorWidget extends StatefulWidget {
  final List<Color> colors;
  final int selectedColorIndex;
  final Function(int) onColorSelected;

  const ProductColorSelectorWidget({
    Key? key,
    required this.colors,
    required this.selectedColorIndex,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  State<ProductColorSelectorWidget> createState() =>
      _ProductColorSelectorWidgetState();
}

class _ProductColorSelectorWidgetState
    extends State<ProductColorSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: List.generate(
            widget.colors.length,
            (index) => GestureDetector(
              onTap: () {
                widget.onColorSelected(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: 4.w),
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: widget.colors[index],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.selectedColorIndex == index
                        ? AppTheme.lightTheme.colorScheme.primary
                        : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.colors[index].withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: widget.selectedColorIndex == index
                    ? Center(
                        child: Icon(
                          Icons.check,
                          color: widget.colors[index].computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                          size: 5.w,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
