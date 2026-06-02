import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'repositories/mock_product_repository.dart';
import 'repositories/product_repository.dart';
import 'screens/home/home_screen.dart';
import 'screens/product_detail/product_detail_screen.dart';

final ProductRepository productRepository = MockProductRepository();

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(repository: productRepository),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) => ProductDetailScreen(
        repository: productRepository,
        productId: state.pathParameters['id'] ?? '',
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Sayfa bulunamadi: ${state.uri}'),
    ),
  ),
);
