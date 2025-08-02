import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HelpSectionWidget extends StatelessWidget {
  final VoidCallback onGuidelinesTap;
  final VoidCallback onMentalHealthTap;
  final VoidCallback onSupportTap;
  final VoidCallback onAboutTap;

  const HelpSectionWidget({
    super.key,
    required this.onGuidelinesTap,
    required this.onMentalHealthTap,
    required this.onSupportTap,
    required this.onAboutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.darkTheme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Text(
              'Help & Support',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildNavigationTile(
            'Community Guidelines',
            'Learn about our community rules',
            'rule',
            onGuidelinesTap,
          ),
          _buildDivider(),
          _buildNavigationTile(
            'Mental Health Resources',
            'Get professional help and support',
            'favorite',
            onMentalHealthTap,
          ),
          _buildDivider(),
          _buildNavigationTile(
            'Contact Support',
            'Get help with your account',
            'support_agent',
            onSupportTap,
          ),
          _buildDivider(),
          _buildNavigationTile(
            'About Whispr',
            'Version 1.0.0',
            'info',
            onAboutTap,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile(
    String title,
    String subtitle,
    String iconName,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.supportTeal.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: AppTheme.supportTeal,
                size: 5.w,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: AppTheme.textTertiary,
              size: 5.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Divider(
        color: AppTheme.darkTheme.colorScheme.outline,
        height: 1,
      ),
    );
  }
}
