import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/cart_item_widget.dart';
import './widgets/cart_summary_widget.dart';
import './widgets/coupon_input_widget.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  bool isLoading = false;
  bool isProcessingCheckout = false;
  String couponCode = '';
  double couponDiscount = 0.0;

  // Mock cart data
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Table and chair set",
      "price": 180.0,
      "quantity": 1,
      "image":
          "https://images.pexels.com/photos/1350789/pexels-photo-1350789.jpeg?auto=compress&cs=tinysrgb&w=400",
    },
    {
      "id": 2,
      "name": "Modern dining room set",
      "price": 180.0,
      "quantity": 1,
      "image":
          "https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=400",
    },
    {
      "id": 3,
      "name": "Modern double bed",
      "price": 180.0,
      "quantity": 1,
      "image":
          "https://images.pexels.com/photos/1571468/pexels-photo-1571468.jpeg?auto=compress&cs=tinysrgb&w=400",
    },
  ];

  double get subtotal {
    return cartItems.fold(
        0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get total {
    return subtotal - couponDiscount;
  }

  void _updateQuantity(int itemId, int newQuantity) {
    setState(() {
      final itemIndex = cartItems.indexWhere((item) => item['id'] == itemId);
      if (itemIndex != -1) {
        if (newQuantity <= 0) {
          cartItems.removeAt(itemIndex);
        } else {
          cartItems[itemIndex]['quantity'] = newQuantity;
        }
      }
    });
  }

  void _removeItem(int itemId) {
    setState(() {
      cartItems.removeWhere((item) => item['id'] == itemId);
    });
  }

  void _applyCoupon(String code) {
    setState(() {
      isLoading = true;
      couponCode = code;
    });

    // Simulate coupon validation
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          isLoading = false;
          // Mock coupon validation
          if (code.toLowerCase() == 'save10') {
            couponDiscount = subtotal * 0.1;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Coupon applied! You saved \$${couponDiscount.toStringAsFixed(2)}'),
                backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              ),
            );
          } else {
            couponDiscount = 0.0;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Invalid coupon code'),
                backgroundColor: AppTheme.lightTheme.colorScheme.error,
              ),
            );
          }
        });
      }
    });
  }

  void _proceedToCheckout() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
        ),
      );
      return;
    }

    setState(() {
      isProcessingCheckout = true;
    });

    // Simulate checkout process
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isProcessingCheckout = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Proceeding to checkout with \$${total.toStringAsFixed(2)}'),
            backgroundColor: AppTheme.lightTheme.colorScheme.primary,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.shadow,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppTheme
                            .lightTheme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomIconWidget(
                        iconName: 'arrow_back',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 6.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'MY CART',
                    style:
                        AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            // Cart Content
            Expanded(
              child: cartItems.isEmpty
                  ? _buildEmptyCart()
                  : Column(
                      children: [
                        // Cart Items List
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];
                              return CartItemWidget(
                                item: item,
                                onQuantityChanged: _updateQuantity,
                                onRemove: _removeItem,
                              );
                            },
                          ),
                        ),

                        // Coupon Input
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: CouponInputWidget(
                            onApplyCoupon: _applyCoupon,
                            isLoading: isLoading,
                          ),
                        ),

                        // Cart Summary and Checkout
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.surface,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightTheme.colorScheme.shadow,
                                blurRadius: 8,
                                offset: const Offset(0, -2),
                              ),
                            ],
                          ),
                          child: CartSummaryWidget(
                            subtotal: subtotal,
                            discount: couponDiscount,
                            total: total,
                            onCheckout: _proceedToCheckout,
                            isProcessing: isProcessingCheckout,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'shopping_cart',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20.w,
          ),
          SizedBox(height: 2.h),
          Text(
            'Your cart is empty',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Add some furniture to get started',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeScreen,
                (route) => false,
              );
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}
