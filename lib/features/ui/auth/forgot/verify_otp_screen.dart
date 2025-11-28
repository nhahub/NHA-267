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
    return BlocListener<ForgotViewModel, ForgotStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ForgotLoadingState) {
          DialogUtils.showLoading(
              context: context, message: 'جاري المعالجة...');
        } else {
          DialogUtils.hideLoading(context);
        }
        if (state is ForgotOtpVerifiedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم التحقق من الكود بنجاح')),
          );
        } else if (state is ForgotPasswordResetState) {
          DialogUtils.showMessage(
            context: context,
            title: 'تم التغيير',
            message: 'تم تحديث كلمة المرور بنجاح',
            posActionName: 'تسجيل الدخول',
            posAction: () {
              Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
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
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: const Text('تأكيد الكود وتعيين كلمة المرور'),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
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
                    SizedBox(height: 16.h),
                    Text(
                      'أدخل كود التحقق المرسل إلى هاتفك',
                      style: AppStyles.semi20Primary
                          .copyWith(color: AppColors.whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: viewModel.otpController,
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'أدخل الكود';
                        if (v.trim().length < 4) return 'كود غير صحيح';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'كود التحقق (OTP)',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: viewModel.newPasswordController,
                      obscureText: true,
                      validator: AppValidators.validatePassword,
                      decoration: InputDecoration(
                        hintText: 'كلمة مرور جديدة',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      controller: viewModel.reNewPasswordController,
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return 'أعد إدخال كلمة المرور';
                        if (v.trim() !=
                            viewModel.newPasswordController.text.trim()) {
                          return 'كلمتا المرور غير متطابقتين';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'تأكيد كلمة المرور',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: viewModel.verifyOtp,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              backgroundColor: AppColors.whiteColor,
                              foregroundColor: AppColors.primaryColor,
                            ),
                            child: const Text('تأكيد الكود'),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: viewModel.resetPassword,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              backgroundColor: AppColors.whiteColor,
                              foregroundColor: AppColors.primaryColor,
                            ),
                            child: const Text('تحديث كلمة المرور'),
                          ),
                        ),
                      ],
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
