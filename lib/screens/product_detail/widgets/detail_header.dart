import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../widgets/brand_logo.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.matteBlack,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          TextButton.icon(
            onPressed: () => context.go('/'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.ivory,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Geri'),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: InkWell(
              onTap: () => context.go('/'),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BrandLogo(size: 40),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'Kubra Deniz KUYUMCULUK',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
