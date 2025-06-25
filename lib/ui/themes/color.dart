import 'package:flutter/material.dart';

/// Centralized color palette with shade-based naming.
/// Shade numbers follow a logical brightness progression (e.g. 100 < 200 < 300).
class AppColors {
  // --- Core / Brand Colors ---
  /// Primary brand color (base)
  static const Color blue500 = Color(0xFF1FA1DB); // primary
  static const Color blue400 = Color(0xFF39BDF6); // secondary / hover
  static const Color blue300 = Color(0xFF78D6FF);
  static const Color blue200 = Color(0xFFB9EAFF);
  static const Color blue100 = Color(0xFFDBF4FF);

  // --- Neutrals ---
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Base background (usually used behind scaffold or screens)
  static const Color gray50 = Color(0xFFFBFBFD); // background

  /// Light surfaces (cards, containers, etc.)
  static const Color gray100 = Color(0xFFF9F9F9); // lightBackground

  /// Text and UI grays
  static const Color gray300 = Color(0xFFF3F3F3);
  static const Color gray400 = Color(0xFFA7AEC1); // textSecondary
  static const Color gray500 = Color(0xFF888888); // textMuted
  static const Color gray600 = Color(0xFF8C8E98); // textDisabled
  static const Color gray900 = Color(0xFF191D31); // textPrimary

  // --- Status Colors ---
  static const Color green500 = Color(0xFF00D261); // success
  static const Color red500 = Color(0xFFFF0000); // error
}
