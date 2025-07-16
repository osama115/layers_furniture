import 'package:flutter/material.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/product_detail_screen/product_detail_screen.dart';
import '../presentation/shopping_cart_screen/shopping_cart_screen.dart';
import '../presentation/discovery_screen/discovery_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String homeScreen = '/home-screen';
  static const String productDetailScreen = '/product-detail-screen';
  static const String shoppingCartScreen = '/shopping-cart-screen';
  static const String discoveryScreen = '/discovery-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const HomeScreen(),
    homeScreen: (context) => const HomeScreen(),
    productDetailScreen: (context) => const ProductDetailScreen(),
    shoppingCartScreen: (context) => const ShoppingCartScreen(),
    discoveryScreen: (context) => const DiscoveryScreen(),
    // TODO: Add your other routes here
  };
}
