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
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          title: const Text('استعادة كلمة المرور'),
          backgroundColor: AppColors.primaryColor,
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
                    SizedBox(height: 24.h),
                    Text(
                      'ادخل رقم الهاتف المرتبط بحسابك',
                      style: AppStyles.semi20Primary
                          .copyWith(color: AppColors.whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      controller: viewModel.phoneController,
                      keyboardType: TextInputType.phone,
                      validator: AppValidators.validatePhoneNumber,
                      decoration: InputDecoration(
                        hintText: 'رقم الهاتف',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: viewModel.sendOtp,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: AppColors.primaryColor,
                      ),
                      child: const Text('إرسال الكود'),
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
