import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final TextStyle textStyle;
  final void Function()? onPressed;

  const CustomElevatedButton(
      {super.key,
        required this.text,
        required this.onPressed,
        required this.backgroundColor,
        required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // إزالة العرض الثابت هنا للسماح له بالتكيف
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r),
          ),
        ),
      ),
      // 💡 استخدام SizedBox لتحديد الارتفاع المطلوب وضمان عرض كامل
      child: SizedBox(
        height: 64.h,
        width: double.infinity, // 💡 تم التعديل ليأخذ العرض الكامل
        child: Center(
          child: AutoSizeText(text, style: textStyle),
        ),
      ),
    );
  }
}