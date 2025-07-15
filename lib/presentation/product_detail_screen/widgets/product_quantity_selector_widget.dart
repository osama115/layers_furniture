import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProductQuantitySelectorWidget extends StatefulWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  final int minQuantity;
  final int maxQuantity;

  const ProductQuantitySelectorWidget({
    Key? key,
    required this.quantity,
    required this.onQuantityChanged,
    this.minQuantity = 1,
    this.maxQuantity = 99,
  }) : super(key: key);

  @override
  State<ProductQuantitySelectorWidget> createState() =>
      _ProductQuantitySelectorWidgetState();
}

class _ProductQuantitySelectorWidgetState
    extends State<ProductQuantitySelectorWidget> {
  void _decrementQuantity() {
    if (widget.quantity > widget.minQuantity) {
      widget.onQuantityChanged(widget.quantity - 1);
    }
  }

  void _incrementQuantity() {
    if (widget.quantity < widget.maxQuantity) {
      widget.onQuantityChanged(widget.quantity + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            // Decrease Button
            GestureDetector(
              onTap: _decrementQuantity,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: widget.quantity > widget.minQuantity
                      ? Colors.grey.shade200
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.remove,
                  color: widget.quantity > widget.minQuantity
                      ? AppTheme.lightTheme.colorScheme.onSurface
                      : Colors.grey.shade400,
                  size: 5.w,
                ),
              ),
            ),

            SizedBox(width: 6.w),

            // Quantity Display
            Container(
              width: 15.w,
              height: 12.w,
              alignment: Alignment.center,
              child: Text(
                widget.quantity.toString(),
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(width: 6.w),

            // Increase Button
            GestureDetector(
              onTap: _incrementQuantity,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: widget.quantity < widget.maxQuantity
                      ? Colors.grey.shade200
                      : Colors.grey.shade100,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: widget.quantity < widget.maxQuantity
                      ? AppTheme.lightTheme.colorScheme.onSurface
                      : Colors.grey.shade400,
                  size: 5.w,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
