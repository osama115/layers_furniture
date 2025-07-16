import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './brand_card_widget.dart';
import './product_discovery_card_widget.dart';

class BrandShowcaseGridWidget extends StatelessWidget {
  final bool isLoading;
  final Function(Map<String, dynamic>) onProductTap;
  final Function(Map<String, dynamic>) onAddToCart;

  const BrandShowcaseGridWidget({
    Key? key,
    required this.isLoading,
    required this.onProductTap,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: CircularProgressIndicator(
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final items = _getGridItems();
          if (index >= items.length) return null;

          final item = items[index];

          if (item['type'] == 'product') {
            return ProductDiscoveryCardWidget(
              product: item,
              onTap: () => onProductTap(item),
              onAddToCart: () => onAddToCart(item),
            );
          } else {
            return BrandCardWidget(
              brand: item,
              onTap: () => onProductTap(item),
            );
          }
        },
        childCount: _getGridItems().length,
      ),
    );
  }

  List<Map<String, dynamic>> _getGridItems() {
    return [
      {
        'type': 'product',
        'name': 'LOVANO Dining Chair',
        'category': 'DINING CHAIR',
        'brand': 'LOVANO',
        'price': '\$299',
        'image':
            'https://images.pexels.com/photos/1148955/pexels-photo-1148955.jpeg?auto=compress&cs=tinysrgb&w=800',
        'description':
            'Comfortable green fabric dining chair with modern design',
        'rating': 4.8,
        'colors': ['Green', 'Blue', 'Gray'],
        'inStock': true,
      },
      {
        'type': 'brand',
        'name': 'noah',
        'description': 'Modern furniture collection',
        'image':
            'https://images.pixabay.com/photo-2016/04/18/08/50/kitchen-1336160_1280.jpg',
        'icon': 'access_time',
        'featured': true,
      },
      {
        'type': 'product',
        'name': 'MEZZO Mirror',
        'category': 'MIRROR',
        'brand': 'MEZZO',
        'price': '\$179',
        'image':
            'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=800&q=80',
        'description': 'Hexagonal mirror with minimalist design',
        'rating': 4.6,
        'colors': ['Gold', 'Silver', 'Black'],
        'inStock': true,
      },
      {
        'type': 'product',
        'name': 'Uchiwa Accent Chair',
        'category': 'ACCENT CHAIR',
        'brand': 'Uchiwa',
        'price': '\$459',
        'image':
            'https://images.pexels.com/photos/1571463/pexels-photo-1571463.jpeg?auto=compress&cs=tinysrgb&w=800',
        'description': 'Blue upholstered accent chair with unique design',
        'rating': 4.9,
        'colors': ['Blue', 'Navy', 'Teal'],
        'inStock': true,
      },
      {
        'type': 'product',
        'name': 'Modern Coffee Table',
        'category': 'COFFEE TABLE',
        'brand': 'LOVANO',
        'price': '\$399',
        'image':
            'https://images.pixabay.com/photo-2016/11/30/08/48/bedroom-1872196_1280.jpg',
        'description': 'Sleek wooden coffee table with glass top',
        'rating': 4.7,
        'colors': ['Walnut', 'Oak', 'Cherry'],
        'inStock': true,
      },
      {
        'type': 'product',
        'name': 'Designer Lamp',
        'category': 'LIGHTING',
        'brand': 'MEZZO',
        'price': '\$129',
        'image':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=800&q=80',
        'description': 'Contemporary table lamp with warm lighting',
        'rating': 4.5,
        'colors': ['White', 'Black', 'Gold'],
        'inStock': false,
      },
    ];
  }
}
