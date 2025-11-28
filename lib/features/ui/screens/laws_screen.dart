import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../pages/home_screen/home_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'profile_screen.dart';

class LawsScreen extends StatelessWidget {
  const LawsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'قانون الإيجار',
          style: AppStyles.semi20Primary.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildArticleCard(
              articleNumber: '1',
              title: 'نطاق التطبيق',
              points: [
                'الوحدات المؤجرة للسكن',
                'الوحدات المؤجرة لغير السكن (محال – مكاتب… إلخ)',
                'إذا كان المستأجر شخصًا طبيعيًا',
                'العقود المُبرمة وفقًا للقانونين: 49 لسنة 1977 و136 لسنة 1981',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '2',
              title: 'مدة العقد',
              points: [
                'عقود الإيجار السكنية تنتهي بعد 7 سنوات من بدء تطبيق القانون',
                'عقود الإيجار غير السكنية تنتهي بعد 5 سنوات من بدء تطبيق القانون',
                'يجوز إنهاء العقد قبل هذه المدة إذا اتفق الطرفان',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '3',
              title: 'تصنيف المناطق',
              points: [
                'تقسيم المناطق إلى: متميزة – متوسطة – اقتصادية',
                'يتم التقسيم بناءً على: موقع المنطقة، نوعية المباني، توافر المرافق، حالة الطرق والخدمات، القيمة الإيجارية لعقارات مشابهة',
                'تنتهي اللجان من عملها خلال 3 أشهر ويمكن التمديد مرة واحدة',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '4',
              title: 'تعديل القيمة الإيجارية للوحدات السكنية',
              points: [
                '20 ضعف القيمة الحالية في المناطق المتميزة (حد أدنى 1000 جنيه)',
                '10 أضعاف القيمة الحالية في المناطق المتوسطة (حد أدنى 400 جنيه)',
                '10 أضعاف القيمة الحالية في المناطق الاقتصادية (حد أدنى 250 جنيه)',
                'لحين انتهاء عمل اللجان: دفع مبلغ مؤقت 250 جنيه شهريًا',
                'بعد قرار المحافظ: حساب الفرق ودفعه على أقساط',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '5',
              title: 'القيمة الإيجارية للوحدات غير السكنية',
              points: [
                'تصبح 5 أضعاف القيمة القانونية الحالية',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '6',
              title: 'الزيادات السنوية',
              points: [
                'تزداد الإيجارات سنويًا بنسبة 15%',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '7',
              title: 'حالات إخلاء الوحدة',
              points: [
                'بعد انتهاء المدة المحددة في المادة (2)',
                'إذا تركت الوحدة مغلقة لأكثر من سنة',
                'إذا كان لدى المستأجر وحدة أخرى مناسبة',
                'في حالة الرفض: يحق للمالك طلب الإخلاء من قاضي الأمور الوقتية',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '8',
              title: 'حق المستأجر في وحدة بديلة',
              points: [
                'يحق للمستأجر أو من انتقل إليه العقد تقديم طلب للحصول على وحدة بديلة من الدولة (إيجار أو تمليك)',
                'بشرط تقديم إقرار بالإخلاء',
                'الأولوية للفئات المستحقة للدعم',
                'تضع الدولة الشروط والإجراءات بقرار من رئيس الوزراء',
              ],
            ),
            SizedBox(height: 12.h),
            _buildArticleCard(
              articleNumber: '9',
              title: 'إلغاء القوانين السابقة',
              points: [
                'بعد مرور 7 سنوات من بدء تنفيذ القانون، تُلغى القوانين التالية:',
                'القانون 49 لسنة 1977',
                'القانون 136 لسنة 1981',
                'القانون 6 لسنة 1997',
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildArticleCard({
    required String articleNumber,
    required String title,
    required List<String> points,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          childrenPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          backgroundColor: AppColors.primaryColor.withOpacity(0.05),
          collapsedBackgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'مادة $articleNumber',
                  style: AppStyles.semi16TextWhite.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.semi16TextWhite.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: points.asMap().entries.map((entry) {
                int index = entry.key;
                String point = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 2.h, left: 8.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: AppStyles.regular14Text.copyWith(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          point,
                          style: AppStyles.regular14Text.copyWith(
                            color: AppColors.primaryDark,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
