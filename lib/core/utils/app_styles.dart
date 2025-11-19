import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  static TextStyle regular16Text = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.fontColor);
  static TextStyle regular16Button = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.whiteColor);
  static TextStyle regular14Text = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primaryDark);
  static TextStyle regular30Text = GoogleFonts.poppins(
      fontSize: 30, fontWeight: FontWeight.w400, color: AppColors.fontColor);
  static TextStyle light14SearchHint = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: AppColors.searchHintColor);
  static TextStyle light16White = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.whiteColor);
  static TextStyle light18HintText = GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      color: AppColors.hintTextColor);
  static TextStyle semi16TextWhite = GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryDark);
  static TextStyle semi20Primary = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static TextStyle semi24White = GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.whiteColor);

  static TextStyle medium14LightPrimary = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDarkLight);
  static TextStyle medium14PrimaryDark = GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primaryDark);
  static TextStyle medium18Header = GoogleFonts.poppins(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryDark);
  static TextStyle medium18White = GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.whiteColor);
  static TextStyle medium20White = GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.whiteColor);
}
