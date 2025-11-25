import 'package:depi_graduation_project/DI/DI.dart';
import 'package:depi_graduation_project/features/ui/auth/register/cubit/register_States.dart';
import 'package:depi_graduation_project/features/ui/auth/register/cubit/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_graduation_project/core/utils/app_colors.dart';
import 'package:depi_graduation_project/core/utils/app_routes.dart';
import 'package:depi_graduation_project/core/utils/app_styles.dart';
import 'package:depi_graduation_project/core/utils/app_validators.dart';
import 'package:depi_graduation_project/core/utils/dialog_utils.dart';
import 'package:depi_graduation_project/features/ui/widgets/custom_text_form_field.dart';
import 'package:depi_graduation_project/features/ui/widgets/custom_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // تم حذف الـ Controllers من هنا لأننا بنستخدم اللي جوه الـ ViewModel

  // متغيرات الـ UI الخاصة بإظهار وإخفاء الباسورد بتبقى Local State عادي
  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;

  // تم حذف الـ AuthRepository لأنه غير مستخدم هنا

  // استدعاء الـ ViewModel
  RegisterViewModel viewModel = getIt<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel, RegisterStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          DialogUtils.showLoading(context: context, message: 'Loading...');
        } else if (state is RegisterErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: state.failers.ErrorMsg, // تأكد ان الاسم failure مش failers لو متاح
            title: "حدث خطأ",
            posActionName: "Ok",
          );
        } else if (state is RegisterSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'تم التسجيل بنجاح',
              title: "انشاء حساب",
              posActionName: "Ok",
              posAction: () {
                // يفضل هنا تنقله لصفحة تسجيل الدخول أو الصفحة الرئيسية
                Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
              }
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: Image.asset(
                        'assets/images/logo.png',
                        color: AppColors.whiteColor,
                        colorBlendMode: BlendMode.srcIn,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "إنشاء حساب جديد",
                    textAlign: TextAlign.center,
                    style: AppStyles.semi24White,
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildLabel("الاسم بالكامل"),
                        CustomTextFormField(
                          controller: viewModel.fullNameController,
                          hintText: "أدخل اسمك بالكامل",
                          keyboardType: TextInputType.name,
                          filledColor: AppColors.whiteColor,
                          validator: AppValidators.validateFullName,
                        ),
                        _buildLabel("رقم الهاتف"),
                        CustomTextFormField(
                          controller: viewModel.phoneController,
                          hintText: "أدخل رقم هاتفك",
                          keyboardType: TextInputType.phone,
                          filledColor: AppColors.whiteColor,
                          validator: AppValidators.validatePhoneNumber,
                        ),
                        _buildLabel("البريد الإلكتروني"),
                        CustomTextFormField(
                          controller: viewModel.emailController,
                          hintText: "أدخل بريدك الإلكتروني",
                          keyboardType: TextInputType.emailAddress,
                          filledColor: AppColors.whiteColor,
                          validator: AppValidators.validateEmail,
                        ),
                        _buildLabel("كلمة المرور"),
                        CustomTextFormField(
                          controller: viewModel.passwordController,
                          hintText: "أدخل كلمة المرور",
                          filledColor: AppColors.whiteColor,
                          isPassword: true,
                          isObscureText: !isPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidators.validatePassword,
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                                    () => isPasswordVisible = !isPasswordVisible),
                            icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.hintTextColor),
                          ),
                        ),
                        _buildLabel("تأكيد كلمة المرور"),
                        CustomTextFormField(
                          controller: viewModel.rePasswordController,
                          hintText: "أعد إدخال كلمة المرور",
                          filledColor: AppColors.whiteColor,
                          isPassword: true,
                          isObscureText: !isRePasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          // -------------------------------------------------------
                          // التعديل هنا: المقارنة مع الكنترولر الخاص بالفيو موديل
                          // -------------------------------------------------------
                          validator: (val) =>
                              AppValidators.validateConfirmPassword(
                                  val, viewModel.passwordController.text),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                                    () => isRePasswordVisible = !isRePasswordVisible),
                            icon: Icon(
                                isRePasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.hintTextColor),
                          ),
                        ),
                        SizedBox(height: 35.h),
                        CustomElevatedButton(
                          backgroundColor: AppColors.whiteColor,
                          textStyle: AppStyles.semi20Primary,
                          text: "إنشاء حساب",
                          onPressed: () {
                            viewModel.register();
                          },
                        ),
                        SizedBox(height: 30.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.loginRoute);
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'لديك حساب بالفعل؟ ',
                                    style: AppStyles.medium18White),
                                TextSpan(
                                  text: 'تسجيل الدخول',
                                  style: AppStyles.medium18White.copyWith(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.whiteColor,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 12.h),
      child: Text(
        text,
        style: AppStyles.medium18White,
      ),
    );
  }
}