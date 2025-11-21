import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final Color? filledColor;
  final Color borderColor;
  final TextStyle? hintStyle;
  final String? hintText;
  final Widget? label;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isObscureText; // الحالة الابتدائية
  final bool isPassword;    // لتفعيل زر العين
  final TextStyle? textStyle;
  final bool readonly;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.label,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscureText = false,
    this.isPassword = false,
    this.filledColor = AppColors.whiteColor,
    this.keyboardType = TextInputType.text,
    this.borderColor = AppColors.whiteColor,
    this.readonly = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // متغير محلي للتحكم في إظهار/إخفاء الباسورد
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    // نأخذ القيمة الابتدائية من الـ Widget
    _obscureText = widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
      child: TextFormField(
        // الخصائص الأساسية
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: _obscureText, // التحكم من خلال المتغير المحلي
        readOnly: widget.readonly,
        style: widget.textStyle ?? TextStyle(fontSize: 16.sp, color: Colors.black),

        // التنسيق (Decoration)
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.filledColor,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          label: widget.label,
          labelStyle: widget.labelStyle,
          prefixIcon: widget.prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

          // منطق الأيقونة الجانبية (Suffix Icon)
          suffixIcon: widget.isPassword
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          )
              : widget.suffixIcon, // لو مش باسورد، اعرض الأيقونة العادية لو موجودة

          // الحدود (Borders)
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: widget.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: AppColors.redColor, width: 2),
          ),
        ),
      ),
    );
  }
}