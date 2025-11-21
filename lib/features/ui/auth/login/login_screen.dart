import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
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

  // شلنا متغير isPasswordVisible لأنه مبقاش ليه لازمة هنا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 91.h,
                  bottom: 87.h,
                  left: 97.w,
                  right: 97.w,
                ),
                // child: Image.asset(AppAssets.appBarLeading),
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
                      style: AppStyles.regular16Text,
                      maxLines: 1,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Form(
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
                              // isObscureText: false, // مش محتاجين نكتبها لأن الديفولت بتاعها false
                              hintText: "اكتب اسمك هنا",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: userNameController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'من فضلك ادخل اسم المستخدم';
                                }
                                return null;
                              },
                            ),

                            Text(
                              "كلمة المرور",
                              style: AppStyles.medium18White,
                            ),
                            // التعديل هنا: شلنا الـ suffixIcon والـ setState
                            CustomTextFormField(
                              isPassword: true,      // ده هيشغل زرار العين تلقائي
                              isObscureText: true,   // ده هيخلي النص يبدأ مخفي
                              keyboardType: TextInputType.visiblePassword,
                              hintText: "اكتب كلمة المرور",
                              hintStyle: AppStyles.light18HintText,
                              filledColor: AppColors.whiteColor,
                              controller: passwordController,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'من فضلك ادخل كلمة المرور';
                                }
                                return null;
                              },
                            ),

                            InkWell(
                              onTap: () {
                                // كود نسيان كلمة المرور
                              },
                              child: Text(
                                'نسيت كلمة المرور',
                                style: AppStyles.regular16Text,
                                textAlign: TextAlign.end,
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 35.h),
                              child: CustomElevatedButton(
                                backgroundColor: AppColors.whiteColor,
                                textStyle: AppStyles.semi20Primary,
                                text: "تسجيل الدخول",
                                onPressed: () {
                                  // هنا ممكن تعمل الفاليديشن وتستدعي الـ Cubit/Bloc
                                  print("تسجيل الدخول: ${userNameController.text}");
                                },
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 30.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.registerRoute,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text.rich(
                                TextSpan(
                                children: [
                                TextSpan(
                                text: 'لا تملك حساب؟ ',
                                  style: AppStyles.medium18White, // الستايل العادي بدون خط
                                ),
                                TextSpan(
                                  text: 'أنشئ حساب جديد',
                                  style: AppStyles.medium18White.copyWith(
                                    decoration: TextDecoration.underline, // الخط هنا بس
                                    decorationColor: Colors.white,
                                    fontWeight: FontWeight.bold, // ممكن تخليه عريض كمان عشان يبرز
                                  ),
                                ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            )
                                        ,

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
}