import 'package:depi_graduation_project/DI/DI.dart';
import 'package:depi_graduation_project/core/utils/app_colors.dart';
import 'package:depi_graduation_project/core/utils/app_routes.dart';
import 'package:depi_graduation_project/core/utils/app_styles.dart';
import 'package:depi_graduation_project/core/utils/app_validators.dart';
import 'package:depi_graduation_project/core/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubit/forgot_states.dart';
import 'cubit/forgot_view_model.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final ForgotViewModel viewModel = getIt<ForgotViewModel>();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is String) {
      viewModel.phoneController.text = arg;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color backgroundColor = isDark ? const Color(0xFF121212) : AppColors.primaryColor;
    Color fieldColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    Color textColor = Colors.white;

    return BlocListener<ForgotViewModel, ForgotStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ForgotLoadingState) {
          DialogUtils.showLoading(context: context, message: 'جاري المعالجة...');
        } else {
          DialogUtils.hideLoading(context);
        }

        if (state is ForgotPasswordResetState) {
          DialogUtils.showMessage(
            context: context,
            title: 'تم التغيير',
            message: 'تم تحديث كلمة المرور بنجاح',
            posActionName: 'تسجيل الدخول',
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (route)=>false);
            },
          );
        } else if (state is ForgotErrorState) {
          DialogUtils.showMessage(
            context: context,
            title: 'خطأ',
            message: state.failers.ErrorMsg,
            posActionName: 'حسناً',
          );
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text('تعيين كلمة المرور'),
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: viewModel.resetFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'أدخل كود التحقق (OTP) وكلمة المرور الجديدة',
                      style: AppStyles.semi20Primary
                          .copyWith(color: textColor, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),

                    TextFormField(
                      controller: viewModel.otpController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'أدخل الكود';
                        if (v.trim().length < 4) return 'كود غير صحيح';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'كود التحقق (OTP)',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: fieldColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.pin, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    TextFormField(
                      controller: viewModel.newPasswordController,
                      obscureText: !isPasswordVisible,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      validator: AppValidators.validatePassword,
                      decoration: InputDecoration(
                        hintText: 'كلمة مرور جديدة',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: fieldColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                          onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    TextFormField(
                      controller: viewModel.reNewPasswordController,
                      obscureText: !isConfirmPasswordVisible,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'أعد إدخال كلمة المرور';
                        if (v.trim() != viewModel.newPasswordController.text.trim()) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'تأكيد كلمة المرور',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: fieldColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.lock_reset, color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                          onPressed: () => setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    ElevatedButton(
                      onPressed: viewModel.resetPassword,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'تحديث كلمة المرور',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}