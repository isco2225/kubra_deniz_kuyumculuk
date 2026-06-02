import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_colors.dart';
import '../../../core/shop_contact.dart';
import '../../../widgets/brand_logo.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchPhone() async {
    await launchUrl(ShopContact.phoneUri);
  }

  Future<void> _launchWhatsApp() async {
    final uri = Uri.parse(
      ShopContact.whatsAppUrl(
        message: 'Merhaba, ürünler hakkında bilgi almak istiyorum.',
      ),
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchMaps() async {
    final uri = Uri.parse(ShopContact.mapsUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchInstagram() async {
    final uri = Uri.parse(ShopContact.instagramUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 860;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.charcoal, AppColors.matteBlack],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -30,
              bottom: -30,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gold.withValues(alpha: 0.07),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isNarrow ? 22 : 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ShopContact.shopName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: AppColors.ivory),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Yeni koleksiyonlar, sipariş süreci ve ürün detayları için '
                              'mağazamızı ziyaret edebilir veya aşağıdaki kanallardan bize ulaşabilirsiniz.',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppColors.ivory.withValues(
                                      alpha: 0.78,
                                    ),
                                    height: 1.55,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (!isNarrow) ...[
                        const SizedBox(width: 24),
                        const BrandLogo(size: 72),
                      ],
                    ],
                  ),
                  if (isNarrow) ...[
                    const SizedBox(height: 20),
                    const Center(child: BrandLogo(size: 64)),
                  ],
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isNarrow ? 16 : 22),
                    decoration: BoxDecoration(
                      color: AppColors.ivory.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.22),
                      ),
                    ),
                    child: Column(
                      children: [
                        ContactInfoTile(
                          icon: Icons.phone_in_talk_outlined,
                          label: 'Telefon',
                          value: ShopContact.phoneDisplay,
                          onTap: _launchPhone,
                        ),
                        const ContactDivider(),
                        ContactInfoTile(
                          icon: Icons.chat_bubble_outline,
                          label: 'WhatsApp',
                          value: ShopContact.phoneDisplay,
                          onTap: _launchWhatsApp,
                        ),
                        const ContactDivider(),
                        ContactInfoTile(
                          icon: Icons.location_on_outlined,
                          label: 'Adres',
                          value: ShopContact.address,
                          onTap: _launchMaps,
                        ),
                        const ContactDivider(),
                        ContactInfoTile(
                          icon: Icons.schedule_outlined,
                          label: 'Çalışma saatleri',
                          value: ShopContact.workingHours,
                        ),
                        const ContactDivider(),
                        ContactInfoTile(
                          icon: Icons.camera_alt_outlined,
                          label: 'Instagram',
                          value: '@kubradenizkuyumculuk',
                          onTap: _launchInstagram,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactDivider extends StatelessWidget {
  const ContactDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(
        height: 1,
        color: AppColors.gold.withValues(alpha: 0.15),
      ),
    );
  }
}

class ContactInfoTile extends StatelessWidget {
  const ContactInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.gold, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.gold,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.ivory.withValues(alpha: 0.9),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        if (onTap != null)
          Icon(
            Icons.arrow_outward_rounded,
            size: 18,
            color: AppColors.gold.withValues(alpha: 0.7),
          ),
      ],
    );

    if (onTap == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: content,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: content,
        ),
      ),
    );
  }
}
