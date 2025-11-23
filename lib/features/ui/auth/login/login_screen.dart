import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/dialog_utils.dart'; // 💡 إضافة DialogUtils
import 'package:depi_graduation_project/domain/repositories/auth_repository_impl.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // اللوجو
              Padding(
                padding: EdgeInsets.only(
                  top: 91.h,
                  bottom: 87.h,
                ),
                child: SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: Image.asset(
                    'assets/images/logo.png',
                    color: AppColors.whiteColor,
                    colorBlendMode: BlendMode.srcIn,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AutoSizeText(
                      'اهلا بيك',
                      style: AppStyles.semi24White,
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      'سجّل دخولك لمتابعة جميع القوانين ',
                      style: AppStyles.light16White,
                      maxLines: 1,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "اسم المستخدم",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: false,
                              keyboardType: TextInputType.text,
                              isObscureText: false,
                              hintText: "اكتب اسمك هنا",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: userNameController,
                              validator: AppValidators.validateUsername,
                            ),

                            Text(
                              "كلمة المرور",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              isObscureText: !isPasswordVisible,
                              hintText: "اكتب كلمة المرور",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: passwordController,
                              validator: AppValidators.validatePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  // الانتقال لصفحة نسيت كلمة المرور
                                  Navigator.pushNamed(context, AppRoutes.forgotPasswordRoute);
                                },
                                child: Text(
                                  'نسيت كلمة المرور',
                                  style: AppStyles.medium18White,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 35.h),
                              child: CustomElevatedButton(
                                backgroundColor: AppColors.whiteColor,
                                textStyle: AppStyles.semi20Primary,
                                text: "تسجيل الدخول",
                                onPressed: _onLoginPressed,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  // التنقل لصفحة التسجيل
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.registerRoute,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        ' لا تملك حساب؟ أنشئ حساب جديد',
                                        style: AppStyles.medium18White,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    // 💡 إظهار شاشة التحميل
    DialogUtils.showLoading(context: context, message: "جاري تسجيل الدخول...");

    final result = await _authRepository.loginUser(
      username: userNameController.text.trim(),
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
            message: "تم تسجيل الدخول بنجاح!",
            posActionName: "متابعة",
            posAction: () {
              // الانتقال لصفحة الهوم مباشرة
              Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
            }
        );
      },
    );
  }
}