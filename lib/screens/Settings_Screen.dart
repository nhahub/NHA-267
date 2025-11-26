import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_graduation_project/core/utils/theme_manager.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const SettingsScreen({super.key, this.onBack});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'الاعدادات',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack ?? () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    // Profile Image
                    CircleAvatar(
                      radius: 35.r,
                      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.12),
                      child: Icon(
                        Icons.person,
                        size: 50.sp,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // User Name and Edit Icon
                    Expanded(
                      child: Text(
                        'الحج محمد',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.edit,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Settings Options
              _buildSettingsTile(
                icon: Icons.person,
                title: 'الحساب',
                subtitle: 'Privacy, security, change email or number',
                onTap: () {},
              ),
              Divider(height: 1.h, color: Colors.grey[300]),
              _buildSettingsTile(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Message, group & call tones',
                onTap: () {},
              ),
              Divider(height: 1.h, color: Colors.grey[300]),
              _buildSettingsTile(
                icon: Icons.headphones,
                title: 'Help',
                subtitle: 'Help centre, contact us, privacy policy',
                onTap: () {},
              ),
              Divider(height: 1.h, color: Colors.grey[300]),
              // Theme toggle row
              ValueListenableBuilder<bool>(
                valueListenable: ThemeManager.isDark,
                builder: (context, isDark, _) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 0.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.brightness_6,
                          size: 32.sp,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الوضع الليلي',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                isDark ? 'قيد التشغيل' : 'قيد الإيقاف',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isDark,
                          activeColor: Theme.of(context).colorScheme.secondary,
                          activeTrackColor: Theme.of(context).colorScheme.secondary.withOpacity(0.36),
                          onChanged: (v) => ThemeManager.toggleTheme(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 0.w),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).iconTheme.color,
              size: 32.sp,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleMedium?.color,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
