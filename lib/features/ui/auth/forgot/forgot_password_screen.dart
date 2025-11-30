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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotViewModel viewModel = getIt<ForgotViewModel>();

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
          DialogUtils.showLoading(context: context, message: 'جاري الإرسال...');
        } else {
          DialogUtils.hideLoading(context);
        }

        if (state is ForgotOtpSentState) {
          DialogUtils.showMessage(
            context: context,
            title: 'تم الإرسال',
            message: 'تم إرسال كود التحقق إلى رقم هاتفك',
            posActionName: 'متابعة',
            posAction: () {
              Navigator.pushNamed(
                  context, '${AppRoutes.forgotPasswordRoute}/verify',
                  arguments: viewModel.phoneController.text.trim());
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
          title: const Text('استعادة كلمة المرور'),
          backgroundColor: backgroundColor,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: viewModel.sendFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40.h),

                    Icon(
                      Icons.lock_reset,
                      size: 80.sp,
                      color: Colors.white,
                    ),
                    SizedBox(height: 24.h),

                    Text(
                      'ادخل رقم الهاتف المرتبط بحسابك\nلاستلام كود التحقق',
                      style: AppStyles.semi20Primary
                          .copyWith(color: textColor, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),

                    TextFormField(
                      controller: viewModel.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: AppValidators.validatePhoneNumber,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black), // لون الكتابة
                      decoration: InputDecoration(
                        hintText: 'رقم الهاتف',
                        hintStyle: TextStyle(color: Colors.grey),
                        fillColor: fieldColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none),
                        prefixIcon: const Icon(Icons.phone_android, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    ElevatedButton(
                      onPressed: viewModel.sendOtp,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'إرسال الكود',
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