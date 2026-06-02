import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../widgets/product_image.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 900;
    final horizontalPad = width < 600 ? 16.0 : 20.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPad, 12, horizontalPad, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.matteBlack, AppColors.charcoal],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: isNarrow ? -40 : -20,
                top: isNarrow ? -60 : -30,
                child: Container(
                  width: isNarrow ? 220 : 320,
                  height: isNarrow ? 220 : 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: isNarrow ? -30 : 40,
                bottom: isNarrow ? -50 : 20,
                child: Container(
                  width: isNarrow ? 140 : 200,
                  height: isNarrow ? 140 : 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(isNarrow ? 22 : 32),
                child: Flex(
                  direction: isNarrow ? Axis.vertical : Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: isNarrow ? 0 : 11,
                      fit: isNarrow ? FlexFit.loose : FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.gold.withValues(alpha: 0.55),
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'ÖZEL TASARIM · GÜNLÜK ŞIKLIK',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AppColors.gold,
                                    letterSpacing: 1.4,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Tarzınızı\nTamamlayın',
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  color: AppColors.ivory,
                                  height: 1.1,
                                  fontSize: isNarrow ? 34 : 42,
                                ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: 56,
                            height: 2,
                            color: AppColors.gold,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Her güne ve her ana uygun şık takıları bir arada bulun. '
                            'Kaliteli işçilikle hazırlanan modellerimizi hemen inceleyin.',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppColors.ivory.withValues(
                                    alpha: 0.82,
                                  ),
                                  height: 1.6,
                                ),
                          ),
                          const SizedBox(height: 24),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              ElevatedButton.icon(
                                onPressed: onExplore,
                                icon: const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 18,
                                ),
                                label: const Text('Ürünleri İncele'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.gold,
                                  foregroundColor: AppColors.matteBlack,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: onExplore,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.gold,
                                  side: BorderSide(
                                    color: AppColors.gold.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Popüler Ürünler'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: isNarrow ? 0 : 28,
                      height: isNarrow ? 24 : 0,
                    ),
                    Flexible(
                      flex: isNarrow ? 0 : 10,
                      fit: isNarrow ? FlexFit.loose : FlexFit.tight,
                      child: HeroImageFrame(isNarrow: isNarrow),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroImageFrame extends StatelessWidget {
  const HeroImageFrame({super.key, required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -10,
            top: -10,
            right: 10,
            bottom: 10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: 0.45),
                  width: 1.5,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: isNarrow ? 16 / 11 : 4 / 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const ProductImage(
                    source: 'assets/zincirler/kalin_altin_set.png',
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.35),
                        ],
                      ),
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
