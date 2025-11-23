import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_graduation_project/core/utils/app_colors.dart';
import 'package:depi_graduation_project/core/utils/app_routes.dart';
import 'package:depi_graduation_project/core/utils/app_styles.dart';
import 'package:depi_graduation_project/core/utils/app_validators.dart';
import 'package:depi_graduation_project/core/utils/dialog_utils.dart';
import 'package:depi_graduation_project/features/ui/widgets/custom_text_form_field.dart';
import 'package:depi_graduation_project/features/ui/widgets/custom_elevated_button.dart';
import 'package:depi_graduation_project/domain/repositories/auth_repository_impl.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;

  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                SizedBox(height: 40.h),

            // اللوجو في الأعلى (كما في شاشة التسجيل)
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

            // عنوان الصفحة
            Text(
              "إنشاء حساب جديد",
              textAlign: TextAlign.center,
              style: AppStyles.semi24White,
            ),
            SizedBox(height: 20.h),

            // فورم البيانات
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // الاسم بالكامل
                  _buildLabel("الاسم بالكامل"),
                  CustomTextFormField(
                    controller: fullNameController,
                    hintText: "أدخل اسمك بالكامل",
                    keyboardType: TextInputType.name,
                    filledColor: AppColors.whiteColor,
                    validator: AppValidators.validateFullName,
                  ),

                  // رقم الهاتف
                  _buildLabel("رقم الهاتف"),
                  CustomTextFormField(
                    controller: phoneController,
                    hintText: "أدخل رقم هاتفك",
                    keyboardType: TextInputType.phone,
                    filledColor: AppColors.whiteColor,
                    validator: AppValidators.validatePhoneNumber,
                  ),

                  // البريد الإلكتروني
                  _buildLabel("البريد الإلكتروني"),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "أدخل بريدك الإلكتروني",
                    keyboardType: TextInputType.emailAddress,
                    filledColor: AppColors.whiteColor,
                    validator: AppValidators.validateEmail,
                  ),

                  // كلمة المرور
                  _buildLabel("كلمة المرور"),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "أدخل كلمة المرور",
                    filledColor: AppColors.whiteColor,
                    isPassword: true,
                    isObscureText: !isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    validator: AppValidators.validatePassword,
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                      icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.hintTextColor),
                    ),
                  ),

                  // تأكيد كلمة المرور
                  _buildLabel("تأكيد كلمة المرور"),
                  CustomTextFormField(
                    controller: rePasswordController,
                    hintText: "أعد إدخال كلمة المرور",
                    filledColor: AppColors.whiteColor,
                    isPassword: true,
                    isObscureText: !isRePasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) => AppValidators.validateConfirmPassword(val, passwordController.text),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => isRePasswordVisible = !isRePasswordVisible),
                      icon: Icon(isRePasswordVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.hintTextColor),
                    ),
                  ),

                  SizedBox(height: 35.h),

                  // زر إنشاء الحساب
                  CustomElevatedButton(
                    backgroundColor: AppColors.whiteColor,
                    textStyle: AppStyles.semi20Primary,
                    text: "إنشاء حساب", // لم نعد نحتاج حالة التحميل في زر
                    onPressed: _onRegisterPressed,
                  ),

                  SizedBox(height: 30.h),

                  // رابط الذهاب لتسجيل الدخول
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'لديك حساب بالفعل؟ ', style: AppStyles.medium18White),
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
    );
  }

  void _onRegisterPressed() async {
    if (!_formKey.currentState!.validate()) return;

    // 💡 إظهار شاشة التحميل
    DialogUtils.showLoading(context: context, message: "جاري إنشاء الحساب...");

    final result = await _authRepository.registerUser(
      fullName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    // 💡 إخفاء شاشة التحميل بعد الانتهاء
    DialogUtils.hideLoading(context);

    result.fold(
          (error) {
        DialogUtils.showMessage(context: context, title: "خطأ", message: error, posActionName: "حسناً");
      },
          (_) {
        DialogUtils.showMessage(
            context: context,
            title: "نجاح",
            message: "تم إنشاء الحساب بنجاح!",
            posActionName: "متابعة",
            posAction: () {
              // الانتقال لصفحة الهوم مباشرة
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
            }
        );
      },
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