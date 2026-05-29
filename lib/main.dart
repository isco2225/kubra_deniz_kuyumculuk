import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_router.dart';
import 'core/app_colors.dart';

void main() {
  runApp(const VitrinKatalogApp());
}

class VitrinKatalogApp extends StatelessWidget {
  const VitrinKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.ivory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.gold,
        primary: AppColors.gold,
        surface: AppColors.ivory,
      ),
    );

    final textTheme = GoogleFonts.robotoTextTheme(baseTheme.textTheme).copyWith(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 52,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 38,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),
      titleLarge: GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16,
        color: AppColors.charcoal,
        height: 1.5,
      ),
    );

    return MaterialApp.router(
      title: 'Kubra Deniz Kuyumculuk',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(textTheme: textTheme),
      routerConfig: appRouter,
    );
  }
}
