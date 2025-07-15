import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_filter_widget.dart';
import './widgets/product_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  bool isLoading = false;
  int _currentIndex = 0;

  // Mock product data
  final List<Map<String, dynamic>> allProducts = [
    {
      "id": 1,
      "name": "Modern Sectional Sofa",
      "description":
          "Comfortable L-shaped sectional perfect for modern living rooms with premium fabric upholstery.",
      "price": "\$180",
      "category": "Couch",
      "image":
          "https://images.pexels.com/photos/1350789/pexels-photo-1350789.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "id": 2,
      "name": "Vintage TV Stand",
      "description":
          "Mid-century modern TV console with ample storage space for entertainment systems.",
      "price": "\$245",
      "category": "TV",
      "image":
          "https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "id": 3,
      "name": "Minimalist Floor Lamp",
      "description":
          "Sleek floor lamp with adjustable brightness, perfect for reading corners and ambient lighting.",
      "price": "\$89",
      "category": "Lamp",
      "image":
          "https://images.pexels.com/photos/1571453/pexels-photo-1571453.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "id": 4,
      "name": "Luxury Velvet Couch",
      "description":
          "Plush velvet sofa with deep seating and elegant design for sophisticated interiors.",
      "price": "\$320",
      "category": "Couch",
      "image":
          "https://images.pexels.com/photos/1571468/pexels-photo-1571468.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "id": 5,
      "name": "Smart TV Cabinet",
      "description":
          "Contemporary TV unit with cable management and storage compartments for modern homes.",
      "price": "\$195",
      "category": "TV",
      "image":
          "https://images.pexels.com/photos/1571471/pexels-photo-1571471.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "id": 6,
      "name": "Industrial Table Lamp",
      "description":
          "Metal table lamp with Edison bulb design, adding industrial charm to any workspace.",
      "price": "\$65",
      "category": "Lamp",
      "image":
          "https://images.pexels.com/photos/1571474/pexels-photo-1571474.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "id": 7,
      "name": "Scandinavian Loveseat",
      "description":
          "Two-seater sofa with clean lines and natural wood frame, embodying Nordic design principles.",
      "price": "\$280",
      "category": "Couch",
      "image":
          "https://images.pexels.com/photos/1571477/pexels-photo-1571477.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
    {
      "id": 8,
      "name": "Pendant Ceiling Lamp",
      "description":
          "Modern hanging lamp with geometric design, perfect for dining areas and kitchen islands.",
      "price": "\$125",
      "category": "Lamp",
      "image":
          "https://images.pexels.com/photos/1571480/pexels-photo-1571480.jpeg?auto=compress&cs=tinysrgb&w=800",
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'All') {
      return allProducts;
    }
    return (allProducts as List)
        .where((dynamic product) =>
            (product as Map<String, dynamic>)['category'] == selectedCategory)
        .toList()
        .cast<Map<String, dynamic>>();
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      isLoading = true;
    });

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      isLoading = true;
    });

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation based on index
    switch (index) {
      case 0:
        // Already on Home
        break;
      case 1:
        // Navigate to Search
        break;
      case 2:
        // Navigate to Cart
        break;
      case 3:
        // Navigate to Favorites
        break;
      case 4:
        // Navigate to Camera
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with LAYERS brand and search
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LAYERS',
                    style:
                        AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle search tap
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppTheme
                            .lightTheme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CustomIconWidget(
                        iconName: 'search',
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 6.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Category Filter
            CategoryFilterWidget(
              selectedCategory: selectedCategory,
              onCategorySelected: _onCategorySelected,
            ),

            // Product Grid
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: AppTheme.lightTheme.colorScheme.primary,
                child: isLoading
                    ? _buildLoadingGrid()
                    : filteredProducts.isEmpty
                        ? _buildEmptyState()
                        : _buildProductGrid(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        selectedItemColor: AppTheme.lightTheme.colorScheme.primary,
        unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _currentIndex == 0
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'search',
              color: _currentIndex == 1
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'shopping_cart',
              color: _currentIndex == 2
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'favorite',
              color: _currentIndex == 3
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'camera_alt',
              color: _currentIndex == 4
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 6.w,
            ),
            label: 'Camera',
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ProductCardWidget(
          product: product,
          onTap: () {
            // Navigate to product detail
          },
        );
      },
    );
  }

  Widget _buildLoadingGrid() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 3.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
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
              Container(
                width: 20.w,
                height: 15.h,
                decoration: BoxDecoration(
                  color:
                      AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: AppTheme
                            .lightTheme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      width: 60.w,
                      height: 1.5.h,
                      decoration: BoxDecoration(
                        color: AppTheme
                            .lightTheme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Container(
                      width: 30.w,
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: AppTheme
                            .lightTheme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'chair',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20.w,
          ),
          SizedBox(height: 2.h),
          Text(
            'No furniture found',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try browsing all categories or check back later',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () {
              _onCategorySelected('All');
            },
            child: const Text('Browse All Categories'),
          ),
        ],
      ),
    );
  }
}
