import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// تأكد من صحة المسارات حسب هيكلة مشروعك
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
// import '../../../../core/utils/app_validators.dart'; // قم بإلغاء التعليق إذا كان الملف موجوداً
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // المتحكمات
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // مفتاح التحقق من الفورم
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. اللوجو والمساحة العلوية
              Padding(
                padding: EdgeInsets.only(
                  top: 60.h,
                  bottom: 40.h,
                ),
                child: SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: Icon(
                    Icons.gavel_rounded, // أيقونة قانونية مؤقتة بدلاً من الصورة
                    size: 100,
                    color: Colors.white,
                  ),
                  // يمكنك استخدام الصورة بدلاً من الأيقونة كالتالي:
                  // child: Image.asset(
                  //   'assets/images/logo.png',
                  //   color: AppColors.whiteColor,
                  //   colorBlendMode: BlendMode.srcIn,
                  //   fit: BoxFit.contain,
                  // ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 2. نصوص الترحيب
                    Center(
                      child: AutoSizeText(
                        'أهلاً بك',
                        style: AppStyles.semi24White,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: AutoSizeText(
                        'سجّل دخولك لمتابعة جميع القوانين',
                        style: AppStyles.light16White,
                        maxLines: 1,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Form(
                        key: _formKey, // ربط المفتاح هنا
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 3. حقل اسم المستخدم
                            Text(
                              "اسم المستخدم",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              controller: userNameController,
                              hintText: "اكتب اسمك هنا",
                              keyboardType: TextInputType.text,
                              filledColor: AppColors.whiteColor,
                              // استخدم AppValidators.validateUsername إذا كان الملف موجوداً
                              // validator: AppValidators.validateUsername,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'من فضلك ادخل اسم المستخدم';
                                }
                                return null;
                              },
                            ),

                            // 4. حقل كلمة المرور
                            Text(
                              "كلمة المرور",
                              style: AppStyles.medium18White,
                            ),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: "اكتب كلمة المرور",
                              isPassword: true,      // تفعيل زر العين
                              isObscureText: true,   // إخفاء النص افتراضياً
                              keyboardType: TextInputType.visiblePassword,
                              filledColor: AppColors.whiteColor,
                              // validator: AppValidators.validatePassword,
                              validator: (text) {
                                if (text == null || text.trim().isEmpty) {
                                  return 'من فضلك ادخل كلمة المرور';
                                }
                                if (text.length < 6) {
                                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                                }
                                return null;
                              },
                            ),

                            // 5. رابط نسيان كلمة المرور
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  // الانتقال لصفحة نسيان كلمة المرور
                                },
                                child: Text(
                                  'نسيت كلمة المرور؟',
                                  style: AppStyles.medium18White.copyWith(fontSize: 14.sp),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),

                            // 6. زر تسجيل الدخول
                            Padding(
                              padding: EdgeInsets.only(top: 35.h),
                              child: CustomElevatedButton(
                                backgroundColor: AppColors.whiteColor,
                                textStyle: AppStyles.semi20Primary,
                                text: "تسجيل الدخول",
                                onPressed: () {
                                  // التحقق من صحة البيانات قبل الإرسال
                                  if (_formKey.currentState!.validate()) {
                                    print("Valid form. Login: ${userNameController.text}");
                                    // استدعاء الـ Bloc/Cubit هنا
                                  }
                                },
                              ),
                            ),

                            // 7. رابط إنشاء حساب جديد
                            Padding(
                              padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.registerRoute,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'لا تملك حساب؟ ',
                                            style: AppStyles.medium18White,
                                          ),
                                          TextSpan(
                                            text: 'أنشئ حساب جديد',
                                            style: AppStyles.medium18White.copyWith(
                                              decoration: TextDecoration.underline,
                                              decorationColor: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
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