import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "تم تسجيل الدخول بنجاح",
      "body": "أهلاً بك في تطبيقنا! نتمنى لك تجربة ممتعة ومفيدة.",
      "time": "الآن",
      "isRead": false,
      "icon": Icons.security,
      "color": Colors.green,
    },
    {
      "title": "تحديث جديد للقوانين",
      "body": "تم إضافة قانون الإيجار الجديد لسنة 2025، تصفحه الآن.",
      "time": "منذ 2 ساعة",
      "isRead": false,
      "icon": Icons.gavel,
      "color": AppColors.primaryColor,
    },
    {
      "title": "تنبيه هام",
      "body": "يرجى استكمال بيانات الملف الشخصي للحصول على أفضل تجربة.",
      "time": "أمس",
      "isRead": true,
      "icon": Icons.info_outline,
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color cardColor = isDark ? Colors.grey[900]! : Colors.white;
    Color textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "الإشعارات",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (notifications.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  notifications.clear();
                });
              },
              child: Text(
                "مسح الكل",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState(textColor)
          : ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Dismissible(
            key: Key(item['title'] + index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16.r),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.w),
              child: const Icon(Icons.delete, color: Colors.white, size: 30),
            ),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
            },
            child: _buildNotificationItem(item, cardColor, textColor),
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> item, Color cardColor, Color textColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: item['isRead']
            ? Border.all(color: Colors.transparent)
            : Border.all(color: AppColors.primaryColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: item['color'].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item['icon'], color: item['color'], size: 24.sp),
          ),
          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      item['time'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  item['body'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: textColor.withOpacity(0.7),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          if (!item['isRead'])
            Padding(
              padding: EdgeInsets.only(right: 8.w, top: 5.h),
              child: CircleAvatar(
                radius: 4.r,
                backgroundColor: Colors.red,
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildEmptyState(Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30.r),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 80.sp,
              color: AppColors.primaryColor.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "لا توجد إشعارات حالياً",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "سنخبرك عند وصول أي تحديثات جديدة",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}