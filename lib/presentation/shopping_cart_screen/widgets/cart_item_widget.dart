import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './quantity_selector_widget.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int, int) onQuantityChanged;
  final Function(int) onRemove;

  const CartItemWidget({
    Key? key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 6,
                  offset: const Offset(0, 2)),
            ]),
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Product Image
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImageWidget(
                    imageUrl: item['imageUrl'] ?? '',
                    width: 20.w,
                    height: 15.h,
                    fit: BoxFit.cover)),
            SizedBox(width: 4.w),

            // Product Details
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(item['name'],
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.lightTheme.colorScheme
                                            .onSurface))),
                        GestureDetector(
                            onTap: () => onRemove(item['id']),
                            child: Container(
                                padding: EdgeInsets.all(1.w),
                                decoration: BoxDecoration(
                                    color: AppTheme
                                        .lightTheme.colorScheme.errorContainer,
                                    borderRadius: BorderRadius.circular(4)),
                                child: CustomIconWidget(
                                    iconName: 'close',
                                    color:
                                        AppTheme.lightTheme.colorScheme.error,
                                    size: 4.w))),
                      ]),
                  SizedBox(height: 2.h),

                  // Price and Quantity Controls
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${item['price'].toStringAsFixed(0)}',
                            style: AppTheme.lightTheme.textTheme.titleLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme
                                        .lightTheme.colorScheme.primary)),
                        QuantitySelectorWidget(
                            quantity: item['quantity'],
                            onQuantityChanged: (newQuantity) {
                              onQuantityChanged(item['id'], newQuantity);
                            }),
                      ]),
                ])),
          ]),

          // Divider
          Container(
              margin: EdgeInsets.only(top: 2.h),
              height: 1,
              color: AppTheme.lightTheme.colorScheme.outline.withAlpha(77)),
        ]));
  }
}
