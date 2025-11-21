import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
class CustomTextFormField extends StatelessWidget {
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
  final bool isObscureText; // دي القيمة الابتدائية بس
  final bool isPassword;    // عشان نعرف هل نظهر زرار العين ولا لأ
  final bool isObscureText;
  final bool isPassword;
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
  // متغير محلي للتحكم في الحالة جوه الـ Widget دي بس
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    // أول ما الودجت تفتح، بناخد القيمة اللي جاية من برا
    _obscureText = widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
      child: TextFormField(
        style: widget.textStyle,
        obscureText: _obscureText, // بنستخدم المتغير المحلي هنا
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validator,
        readOnly: widget.readonly,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.filledColor,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          label: widget.label,
          labelStyle: widget.labelStyle,
          prefixIcon: widget.prefixIcon,
          // لو هو باسورد، بنظهر الأيقونة، ولو مش باسورد بنشوف هل فيه suffixIcon مبعوت ولا لأ
          suffixIcon: widget.isPassword
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText; // بنغير المتغير المحلي
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey, // لون مفضل للأيقونة
            ),
          )
              : widget.suffixIcon,
        style: textStyle ?? TextStyle(fontSize: 16.sp, color: AppColors.blackColor),
        obscureText: isObscureText,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        readOnly: readonly,
        decoration: InputDecoration(
          filled: true,
          fillColor: filledColor,
          hintText: hintText,
          hintStyle: hintStyle,
          label: label,
          labelStyle: labelStyle,
          prefixIcon: prefixIcon,
          // 💡 نستخدم suffixIcon كما تم تمريره من LoginScreen (سواء كان زر الإظهار أو أيقونة أخرى)
          suffixIcon: isPassword ? suffixIcon : suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.redColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.redColor, width: 2)),
        ),
      ),
    );
  }
}