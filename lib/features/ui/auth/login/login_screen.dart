import 'package:auto_size_text/auto_size_text.dart';
import 'package:depi_graduation_project/DI/DI.dart';
import 'package:depi_graduation_project/features/ui/auth/login/cubit/login_View_Model.dart';
import 'package:depi_graduation_project/features/ui/auth/login/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/cache/SharedPreference.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/utils/dialog_utils.dart';
// تم حذف import الـ Repository لأنه غير مستخدم
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel viewModel = getIt<LoginViewModel>();
  bool isPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel, LoginStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is LoginLoadingState) {
          DialogUtils.showLoading(context: context, message: "Waiting...");
        } else if (state is LoginErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: state.failers.ErrorMsg,
              title: 'Error',
              posActionName: 'Ok');
       }else if (state is LoginSuccessState) {
          DialogUtils.hideLoading(context);

          // 1. احفظ التوكن
          SharedPreferenceUtils.saveData(key: 'token', value: state.responseEntity.token);

          DialogUtils.showMessage(
              context: context,
              message: "تم تسجيل الدخول بنجاح",
              title: 'نجاح',
              posActionName: 'Ok',
              posAction: () {
                // 2. روح للـ Home
                Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
              });
        }
      },
      child: Scaffold(
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
                          key: viewModel.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "البريد الالكترونى",
                                style: AppStyles.medium18White,
                              ),
                              CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.emailAddress, // يفضل emailAddress بدل text
                                isObscureText: false,
                                hintText: "أدخل بريدك الالكترونى",
                                hintStyle: AppStyles.light18HintText,
                                filledColor: AppColors.whiteColor,
                                controller: viewModel.emailController,
                                validator: AppValidators.validateEmail, // تأكد إن ده بيعمل validate للإيميل
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
                                controller: viewModel.passwordController,
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
                                    Navigator.pushNamed(
                                        context, AppRoutes.forgotPasswordRoute);
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
                                  onPressed: () {
                                    viewModel.login();
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
                                    mainAxisAlignment: MainAxisAlignment.center, // توسيط النص
                                    children: [
                                      Text(
                                        ' لا تملك حساب؟ أنشئ حساب جديد',
                                        style: AppStyles.medium18White,
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
      ),
    );
  }
}