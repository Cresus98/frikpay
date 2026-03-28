import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Design system Finanfa / FrikPay — palette sobre, contraste élevé, hiérarchie claire.
abstract final class AppTheme {
  AppTheme._();

  /// Bleu profond : confiance, finance (évite le violet Material par défaut).
  static const Color _brandPrimary = Color(0xFF0B4F6C);
  static const Color _brandSecondary = Color(0xFF0D9488);
  static const Color _brandAccent = Color(0xFFC27A00);
  static const Color _surface = Color(0xFFF4F6F9);
  static const Color _surfaceCard = Color(0xFFFFFFFF);
  static const Color _onSurface = Color(0xFF111827);
  static const Color _muted = Color(0xFF6B7280);
  static const Color _outline = Color(0xFFE5E7EB);

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _brandPrimary,
      brightness: Brightness.light,
    ).copyWith(
      primary: _brandPrimary,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFC8E6F5),
      onPrimaryContainer: Color(0xFF062D3D),
      secondary: _brandSecondary,
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD1FAF4),
      onSecondaryContainer: Color(0xFF04403A),
      tertiary: _brandAccent,
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFE7C2),
      onTertiaryContainer: Color(0xFF4A3200),
      error: Color(0xFFB91C1C),
      onError: Color(0xFFFFFFFF),
      surface: _surface,
      onSurface: _onSurface,
      onSurfaceVariant: _muted,
      outline: _outline,
      outlineVariant: Color(0xFFF3F4F6),
      shadow: Color(0x1A000000),
      scrim: Color(0x66000000),
      surfaceContainerHighest: Color(0xFFE8ECF0),
    );

    final typography = Typography.material2021(platform: TargetPlatform.android);
    final baseText = typography.black.copyWith(
      displayLarge: typography.black.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: typography.black.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.35,
        color: _onSurface,
      ),
      titleLarge: typography.black.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: _onSurface,
      ),
      titleMedium: typography.black.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: _onSurface,
      ),
      bodyLarge: typography.black.bodyLarge?.copyWith(
        color: _onSurface,
        height: 1.45,
      ),
      bodyMedium: typography.black.bodyMedium?.copyWith(
        color: _muted,
        height: 1.4,
      ),
      labelLarge: typography.black.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: baseText,
      scaffoldBackgroundColor: _surface,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        backgroundColor: _surfaceCard,
        foregroundColor: _onSurface,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: baseText.titleLarge?.copyWith(fontSize: 18),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _surfaceCard,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _outline.withValues(alpha: 0.65)),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: baseText.labelLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontSize: 15,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: colorScheme.outline),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        focusElevation: 4,
        highlightElevation: 4,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: TextStyle(color: _muted, fontSize: 14),
        hintStyle: TextStyle(color: _muted.withValues(alpha: 0.85), fontSize: 15),
      ),
      dividerTheme: DividerThemeData(
        color: _outline,
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _surfaceCard,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: _surfaceCard,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: baseText.titleLarge?.copyWith(fontSize: 20),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surfaceContainerHighest,
        circularTrackColor: colorScheme.surfaceContainerHighest,
      ),
    );
  }

  /// Styles des 4 tuiles accueil (fond + icône) — dérivés du même schéma.
  static List<({Color cardBg, Color iconBg})> homeTiles(ColorScheme cs) => [
        (cardBg: cs.primaryContainer.withValues(alpha: 0.85), iconBg: cs.primary),
        (cardBg: cs.secondaryContainer.withValues(alpha: 0.9), iconBg: cs.secondary),
        (cardBg: cs.tertiaryContainer.withValues(alpha: 0.85), iconBg: cs.tertiary),
        (
          cardBg: cs.surfaceContainerHighest.withValues(alpha: 0.6),
          iconBg: cs.primary,
        ),
      ];
}
