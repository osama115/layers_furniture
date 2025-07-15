import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProductImageCarouselWidget extends StatefulWidget {
  final List<String> images;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;
  final bool isFavorite;

  const ProductImageCarouselWidget({
    Key? key,
    required this.images,
    this.onBackPressed,
    this.onFavoritePressed,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  State<ProductImageCarouselWidget> createState() =>
      _ProductImageCarouselWidgetState();
}

class _ProductImageCarouselWidgetState
    extends State<ProductImageCarouselWidget> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: Stack(
        children: [
          // Image Carousel
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return CustomImageWidget(
                imageUrl: widget.images[index],
                width: 100.w,
                height: 45.h,
                fit: BoxFit.cover,
              );
            },
          ),

          // Header Controls
          Positioned(
            top: 6.h,
            left: 4.w,
            right: 4.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                GestureDetector(
                  onTap: widget.onBackPressed,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ),

                // Brand Element (3D Cube)
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'L',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                // Favorite Button
                GestureDetector(
                  onTap: widget.onFavoritePressed,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.isFavorite
                          ? Colors.red
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dot Indicators
          Positioned(
            bottom: 3.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  width: _currentIndex == index ? 8.w : 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppTheme.lightTheme.colorScheme.primary
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(1.w),
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
