import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';

class AnnualIncreaseScreen extends StatefulWidget {
  const AnnualIncreaseScreen({super.key});

  @override
  State<AnnualIncreaseScreen> createState() => _AnnualIncreaseScreenState();
}

class _AnnualIncreaseScreenState extends State<AnnualIncreaseScreen> {
  String? selectedAreaType;
  final TextEditingController currentRentController = TextEditingController();
  double? calculatedRent;

  final List<String> areaTypes = [
    'منطقة متميزة',
    'منطقة متوسطة',
    'منطقة اقتصادية',
  ];

  void calculateNewRent() {
    if (selectedAreaType == null || currentRentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'يرجى اختيار نوع المنطقة وإدخال الإيجار الحالي',
            style: AppStyles.regular16Button,
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColors.redColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          margin: EdgeInsets.all(16.w),
        ),
      );
      return;
    }

    double currentRent = double.tryParse(currentRentController.text) ?? 0;
    double newRent = 0;

    if (selectedAreaType == 'منطقة متميزة') {
      newRent = currentRent * 20;
      if (newRent < 1000) newRent = 1000;
    } else if (selectedAreaType == 'منطقة متوسطة') {
      newRent = currentRent * 10;
      if (newRent < 400) newRent = 400;
    } else if (selectedAreaType == 'منطقة اقتصادية') {
      newRent = currentRent * 10;
      if (newRent < 250) newRent = 250;
    }

    setState(() {
      calculatedRent = newRent;
    });
  }

  @override
  void dispose() {
    currentRentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor = isDark ? const Color(0xFF121212) : AppColors.whiteColor;
    Color cardColor = isDark ? const Color(0xFF1E1E1E) : AppColors.whiteColor;
    Color textColor = isDark ? Colors.white : AppColors.primaryDark;
    Color hintColor = isDark ? Colors.grey[400]! : AppColors.hintTextColor;
    Color iconColor = isDark ? Colors.white : AppColors.primaryColor;
    Color appBarColor = isDark ? const Color(0xFF121212) : AppColors.primaryColor;
    Color inputFillColor = isDark ? const Color(0xFF2C2C2C) : AppColors.whiteColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'حساب الإيجار الجديد',
          style: AppStyles.semi20Primary.copyWith(color: Colors.white),
        ),
        backgroundColor: appBarColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.h),

            // Title
            Text(
              'احسب الإيجار الجديد وفقًا للقانون المصري',
              style: AppStyles.semi20Primary.copyWith(
                color: isDark ? AppColors.primaryColor : AppColors.primaryColor,
                fontSize: 22.sp,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 32.h),


            Card(
              color: cardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: DropdownButtonFormField<String>(
                  value: selectedAreaType,
                  dropdownColor: cardColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'نوع المنطقة',
                    labelStyle: AppStyles.regular14Text.copyWith(color: iconColor),
                    hintText: 'اختر نوع المنطقة',
                    hintStyle: AppStyles.regular16Text.copyWith(color: hintColor),
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: iconColor,
                    size: 32.sp,
                  ),
                  isExpanded: true,
                  style: AppStyles.regular16Text.copyWith(color: textColor),
                  items: areaTypes.map((String areaType) {
                    return DropdownMenuItem<String>(
                      value: areaType,
                      child: Text(
                        areaType,
                        style: AppStyles.regular16Text.copyWith(color: textColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAreaType = newValue;
                      calculatedRent = null;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 20.h),


            Card(
              color: cardColor,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: TextField(
                  controller: currentRentController,
                  keyboardType: TextInputType.number,
                  style: AppStyles.regular16Text.copyWith(color: textColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'الإيجار الحالي (جنيه)',
                    labelStyle: AppStyles.regular14Text.copyWith(color: iconColor),
                    hintText: 'أدخل قيمة الإيجار الحالي',
                    hintStyle: AppStyles.regular16Text.copyWith(color: hintColor),
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: iconColor,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      calculatedRent = null;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Calculate Button
            ElevatedButton(
              onPressed: calculateNewRent,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                elevation: 4,
              ),
              child: Text(
                'احسب الإيجار الجديد',
                style: AppStyles.semi16TextWhite.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Result Display
            if (calculatedRent != null)
              AnimatedOpacity(
                opacity: calculatedRent != null ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Card(
                  color: cardColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    side: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2.w,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor.withOpacity(0.1),
                          AppColors.primaryColor.withOpacity(0.02),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppColors.greenColor,
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'الإيجار الجديد',
                          style: AppStyles.regular16Text.copyWith(
                            color: textColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          '${calculatedRent!.toStringAsFixed(2)} جنيه',
                          style: AppStyles.semi20Primary.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Divider(
                          color: AppColors.primaryColor.withOpacity(0.3),
                          thickness: 1.5,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'تم الحساب وفقًا للمادة 4 من قانون الإيجار المصري',
                          style: AppStyles.regular14Text.copyWith(
                            color: textColor.withOpacity(0.7),
                            fontSize: 13.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            SizedBox(height: 24.h),

            // Info Card
            Card(
              elevation: 2,
              color: isDark ? const Color(0xFF2C2C2C) : AppColors.primaryColor.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'معلومات هامة',
                          style: AppStyles.semi16TextWhite.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    _buildInfoPoint('منطقة متميزة: الإيجار × 20 (الحد الأدنى 1000 جنيه)', textColor),
                    _buildInfoPoint('منطقة متوسطة: الإيجار × 10 (الحد الأدنى 400 جنيه)', textColor),
                    _buildInfoPoint('منطقة اقتصادية: الإيجار × 10 (الحد الأدنى 250 جنيه)', textColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // عدلنا الدالة عشان تاخد اللون
  Widget _buildInfoPoint(String text, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h, left: 8.w),
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppStyles.regular14Text.copyWith(
                color: textColor.withOpacity(0.9), // ✅ استخدام اللون المتغير
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}