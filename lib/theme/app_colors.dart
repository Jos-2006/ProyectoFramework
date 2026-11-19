import 'package:flutter/material.dart';

/// Paleta de colores oficial basada en la identidad visual de Pequeño Mundo.
/// Color principal extraído directamente del logo (#E00614).
class AppColors {
  AppColors._();

  // Color primario institucional (Rojo Pequeño Mundo)
  static const Color primary = Color(0xFFE00614);
  static const Color primaryDark = Color(0xFFB3040F);
  static const Color primaryLight = Color(0xFFFFEBEC);
  static const Color primaryTint = Color(0xFFFFF5F5);

  // Neutros y superficies
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1E242B);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textMuted = Color(0xFF9E9E9E);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFEDEDED);

  // Acciones y estados en armonía con la gama
  static const Color danger = Color(0xFFD32F2F);
  static const Color actionEdit = Color(0xFF495057);
  static const Color actionDelete = Color(0xFFE00614);
  static const Color badgeBackground = Color(0xFFFFEBEC);
  static const Color badgeText = Color(0xFFB3040F);
  static const Color tableHeader = Color(0xFFFFEBEC);
  static const Color tableHeaderText = Color(0xFFB3040F);
}
