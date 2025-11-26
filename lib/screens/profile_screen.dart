import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = 'الحج محمد';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('صباح الخير',
                          style: AppStyles.regular16Text.copyWith(
                              color: Theme.of(context).colorScheme.primary)),
                      Text(userName,
                          style: AppStyles.medium20White.copyWith(
                              color: Theme.of(context).colorScheme.primary)),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          // فتح شاشة الإعدادات
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text('الإعدادات',
                              style: AppStyles.medium14PrimaryDark.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80.h,
                    width: 80.w,
                    child: Image.asset(
                      'assets/images/logo.png',
                      color: Theme.of(context).colorScheme.primary,
                      colorBlendMode: BlendMode.srcIn,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'محتوى الملف الشخصي',
                  style: AppStyles.medium20White.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}