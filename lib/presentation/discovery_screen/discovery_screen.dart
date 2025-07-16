import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/brand_showcase_grid_widget.dart';
import './widgets/discovery_search_bar_widget.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  void _onSearchChanged(String query) {
    // Implement search logic here
    print('Search query: $query');
  }

  void _onVoiceSearch() {
    // Implement voice search logic here
    print('Voice search activated');
  }

  void _onProductTap(Map<String, dynamic> product) {
    Navigator.pushNamed(
      context,
      AppRoutes.productDetailScreen,
      arguments: product,
    );
  }

  void _onAddToCart(Map<String, dynamic> product) {
    // Add haptic feedback
    // HapticFeedback.lightImpact();

    // Implement add to cart logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to cart'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              // Search Bar Section
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  color: AppTheme.lightTheme.scaffoldBackgroundColor,
                  child: DiscoverySearchBarWidget(
                    controller: _searchController,
                    onSearchChanged: _onSearchChanged,
                    onVoiceSearch: _onVoiceSearch,
                  ),
                ),
              ),

              // Discover New Finds Header
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Row(
                    children: [
                      Text(
                        'Discover New Finds',
                        style: AppTheme.lightTheme.textTheme.headlineSmall
                            ?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '🔥',
                        style: TextStyle(fontSize: 6.w),
                      ),
                    ],
                  ),
                ),
              ),

              // Brand Showcase Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                sliver: BrandShowcaseGridWidget(
                  isLoading: _isLoading,
                  onProductTap: _onProductTap,
                  onAddToCart: _onAddToCart,
                ),
              ),

              // Bottom spacing
              SliverToBoxAdapter(
                child: SizedBox(height: 2.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
