import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  // استخدمنا Cairo لأنه أفضل بديل عربي لـ Poppins
  // ضفنا .sp لكل الأحجام عشان التجاوب مع الشاشات المختلفة

  static TextStyle regular16Text = GoogleFonts.cairo(
      fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.fontColor);

  static TextStyle regular16Button = GoogleFonts.cairo(
      fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.whiteColor);

  static TextStyle regular14Text = GoogleFonts.cairo(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.primaryDark);

  static TextStyle regular30Text = GoogleFonts.cairo(
      fontSize: 30.sp, fontWeight: FontWeight.w400, color: AppColors.fontColor);

  static TextStyle light14SearchHint = GoogleFonts.cairo(
      fontSize: 14.sp,
      fontWeight: FontWeight.w300,
      color: AppColors.searchHintColor);

  static TextStyle light16White = GoogleFonts.cairo(
      fontSize: 16.sp, fontWeight: FontWeight.w300, color: AppColors.whiteColor);

  static TextStyle light18HintText = GoogleFonts.cairo(
      fontSize: 18.sp,
      fontWeight: FontWeight.w300,
      color: AppColors.hintTextColor);

  static TextStyle semi16TextWhite = GoogleFonts.cairo(
      fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.primaryDark);

  static TextStyle semi20Primary = GoogleFonts.cairo(
      fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor);

  static TextStyle semi24White = GoogleFonts.cairo(
      fontSize: 24.sp, fontWeight: FontWeight.w600, color: AppColors.whiteColor);

  static TextStyle medium14LightPrimary = GoogleFonts.cairo(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkLight);

  static TextStyle medium14PrimaryDark = GoogleFonts.cairo(
      fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.primaryDark);

  static TextStyle medium18Header = GoogleFonts.cairo(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDark);

  static TextStyle medium18White = GoogleFonts.cairo(
      fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.whiteColor);

  static TextStyle medium20White = GoogleFonts.cairo(
      fontSize: 20.sp, fontWeight: FontWeight.w500, color: AppColors.whiteColor);
}