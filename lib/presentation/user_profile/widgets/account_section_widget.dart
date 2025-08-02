import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AccountSectionWidget extends StatelessWidget {
  final bool biometricEnabled;
  final int blockedUsersCount;
  final int bookmarkedCount;
  final Function(bool) onBiometricChanged;
  final VoidCallback onPrivacySettingsTap;
  final VoidCallback onBlockedUsersTap;
  final VoidCallback onBookmarksTap;
  final VoidCallback onDataExportTap;

  const AccountSectionWidget({
    super.key,
    required this.biometricEnabled,
    required this.blockedUsersCount,
    required this.bookmarkedCount,
    required this.onBiometricChanged,
    required this.onPrivacySettingsTap,
    required this.onBlockedUsersTap,
    required this.onBookmarksTap,
    required this.onDataExportTap,
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
              'Account & Privacy',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildSwitchTile(
            'Biometric Authentication',
            'Use fingerprint or face ID',
            'fingerprint',
            biometricEnabled,
            onBiometricChanged,
          ),
          _buildDivider(),
          _buildNavigationTile(
            'Privacy Settings',
            'Manage your privacy preferences',
            'privacy_tip',
            onPrivacySettingsTap,
          ),
          _buildDivider(),
          _buildNavigationTile(
            'Blocked Users',
            '$blockedUsersCount blocked users',
            'block',
            onBlockedUsersTap,
          ),
          _buildDivider(),
          _buildNavigationTile(
            'Bookmarked Confessions',
            '$bookmarkedCount saved confessions',
            'bookmark',
            onBookmarksTap,
          ),
          _buildDivider(),
          _buildNavigationTile(
            'Export Data',
            'Download your data',
            'download',
            onDataExportTap,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    String iconName,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.errorRose.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: CustomIconWidget(
              iconName: iconName,
              color: AppTheme.errorRose,
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.accentPurple,
            inactiveThumbColor: AppTheme.textSecondary,
            inactiveTrackColor: AppTheme.textTertiary.withValues(alpha: 0.3),
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
                color: AppTheme.textSecondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: iconName,
                color: AppTheme.textSecondary,
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
