import 'package:depi_graduation_project/core/utils/app_colors.dart';
import 'package:depi_graduation_project/core/utils/app_routes.dart';
import 'package:depi_graduation_project/core/utils/app_styles.dart';
import 'package:depi_graduation_project/features/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
// تأكد من أن المسارات التالية صحيحة حسب مشروعك

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // المتحكمات في النصوص
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // أيقونة التسجيل
                const Center(
                  child: Icon(
                    Icons.person_add_alt_1_outlined,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // عنوان الصفحة
                const Text(
                  "إنشاء حساب جديد",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo', // تأكد من إضافة الخط في pubspec.yaml
                  ),
                ),
                const SizedBox(height: 20),

                // فورم البيانات
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // الاسم بالكامل
                    _buildLabel("الاسم بالكامل"),
                    CustomTextFormField(
                      controller: fullNameController,
                      hintText: "أدخل اسمك ثلاثي",
                      keyboardType: TextInputType.name,
                      filledColor: Colors.white,
                    ),

                    // رقم الهاتف
                    _buildLabel("رقم الهاتف"),
                    CustomTextFormField(
                      controller: phoneController,
                      hintText: "أدخل رقم هاتفك",
                      keyboardType: TextInputType.phone,
                      filledColor: Colors.white,
                    ),

                    // البريد الإلكتروني
                    _buildLabel("البريد الإلكتروني"),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "أدخل بريدك الإلكتروني",
                      keyboardType: TextInputType.emailAddress,
                      filledColor: Colors.white,
                    ),

                    // كلمة المرور
                    _buildLabel("كلمة المرور"),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "أدخل كلمة المرور",
                      filledColor: Colors.white,
                      isPassword: true,
                      isObscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),

                    // تأكيد كلمة المرور
                    _buildLabel("تأكيد كلمة المرور"),
                    CustomTextFormField(
                      controller: rePasswordController,
                      hintText: "أعد إدخال كلمة المرور",
                      filledColor: Colors.white,
                      isPassword: true,
                      isObscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),

                    const SizedBox(height: 35),

                    // زر إنشاء الحساب
                    SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          // كود التسجيل هنا
                          print("جاري التسجيل: ${fullNameController.text}");
                        },
                        child: Text(
                          "إنشاء حساب",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // رابط الذهاب لتسجيل الدخول
                    GestureDetector(
                      onTap: () {
                        // الانتقال لصفحة تسجيل الدخول واستبدال الصفحة الحالية
                        Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'لديك حساب بالفعل؟ ',
                                  style: AppStyles.medium18White,
                                ),
                                TextSpan(
                                  text: 'تسجيل الدخول',
                                  style: AppStyles.medium18White.copyWith(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline, // وضع الخط هنا
                                    decorationColor: Colors.white,
                                    decorationThickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء العناوين فوق الحقول
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 12.0),
      child: Text(
        text,
        style: AppStyles.medium18White, // استخدام الستايل الموحد
      ),
    );
  }
}