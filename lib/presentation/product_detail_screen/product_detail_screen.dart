import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/product_color_selector_widget.dart';
import './widgets/product_image_carousel_widget.dart';
import './widgets/product_quantity_selector_widget.dart';
import './widgets/product_rating_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavorite = false;
  int _selectedColorIndex = 0;
  int _quantity = 1;
  bool _isLoading = false;

  // Sample product data - in real app, this would come from arguments or API
  final List<String> _productImages = [
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
  ];

  final List<Color> _availableColors = [
    Colors.black,
    Colors.grey,
    const Color(0xFF8B4513), // Brown
    const Color(0xFF228B22), // Forest Green
  ];

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onFavoritePressed() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _onColorSelected(int index) {
    setState(() {
      _selectedColorIndex = index;
    });
  }

  void _onQuantityChanged(int newQuantity) {
    setState(() {
      _quantity = newQuantity;
    });
  }

  void _onAddToCart() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isLoading = false;
    });

    // Show success message
    Fluttertoast.showToast(
      msg: "Added to cart successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      textColor: AppTheme.lightTheme.colorScheme.onPrimary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Carousel
                  ProductImageCarouselWidget(
                    images: _productImages,
                    onBackPressed: _onBackPressed,
                    onFavoritePressed: _onFavoritePressed,
                    isFavorite: _isFavorite,
                  ),

                  // Product Information
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rating
                        ProductRatingWidget(
                          rating: 4.8,
                          reviewCount: 128,
                        ),

                        SizedBox(height: 3.h),

                        // Price
                        Text(
                          '\$180',
                          style: AppTheme.lightTheme.textTheme.headlineMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 1.h),

                        // Product Title
                        Text(
                          'Table and chair set',
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        // Color Selection
                        ProductColorSelectorWidget(
                          colors: _availableColors,
                          selectedColorIndex: _selectedColorIndex,
                          onColorSelected: _onColorSelected,
                        ),

                        SizedBox(height: 4.h),

                        // Product Description
                        Text(
                          'Description',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 2.h),

                        Text(
                          'An elegant fusion of traditional Egyptian craftsmanship and modern design.',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 2.h),

                        Text(
                          'A timeless table and chair set made for refined living and lasting comfort.',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 4.h),

                        // Quantity Selection
                        ProductQuantitySelectorWidget(
                          quantity: _quantity,
                          onQuantityChanged: _onQuantityChanged,
                        ),

                        SizedBox(height: 6.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to Cart Button
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 12.h,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5A3D),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 6.w,
                          width: 6.w,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Add to cart',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
