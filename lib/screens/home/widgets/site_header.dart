import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../widgets/brand_logo.dart';

class SiteHeader extends StatelessWidget {
  const SiteHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 780;
    return Container(
      color: AppColors.matteBlack,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: [
          const BrandLogo(size: 46),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Kubra Deniz KUYUMCULUK',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.gold,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (!isMobile)
            Wrap(
              spacing: 26,
              children: const [
                SiteMenuItem(label: 'Ana Sayfa'),
                SiteMenuItem(label: 'Koleksiyonlar'),
                SiteMenuItem(label: 'İletişim'),
              ],
            ),
        ],
      ),
    );
  }
}

class SiteMenuItem extends StatelessWidget {
  const SiteMenuItem({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: AppColors.ivory,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
