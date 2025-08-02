import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String anonymousId;
  final String? pseudonym;
  final String? avatarUrl;
  final VoidCallback onRegenerateId;
  final VoidCallback onEditPseudonym;
  final VoidCallback onSelectAvatar;

  const ProfileHeaderWidget({
    super.key,
    required this.anonymousId,
    this.pseudonym,
    this.avatarUrl,
    required this.onRegenerateId,
    required this.onEditPseudonym,
    required this.onSelectAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: AppTheme.darkTheme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Avatar and ID Section
          Row(
            children: [
              // Avatar
              GestureDetector(
                onTap: onSelectAvatar,
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.darkTheme.colorScheme.secondaryContainer,
                    border: Border.all(
                      color: AppTheme.accentPurple,
                      width: 2,
                    ),
                  ),
                  child: avatarUrl != null
                      ? ClipOval(
                          child: CustomImageWidget(
                            imageUrl: avatarUrl!,
                            width: 16.w,
                            height: 16.w,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CustomIconWidget(
                          iconName: 'person',
                          color: AppTheme.textSecondary,
                          size: 8.w,
                        ),
                ),
              ),
              SizedBox(width: 4.w),
              // ID and Pseudonym
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          anonymousId,
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        GestureDetector(
                          onTap: onRegenerateId,
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.accentPurple.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(1.w),
                            ),
                            child: CustomIconWidget(
                              iconName: 'refresh',
                              color: AppTheme.accentPurple,
                              size: 4.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    GestureDetector(
                      onTap: onEditPseudonym,
                      child: Row(
                        children: [
                          Text(
                            pseudonym ?? 'Add pseudonym',
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: pseudonym != null
                                  ? AppTheme.textSecondary
                                  : AppTheme.textTertiary,
                              fontStyle: pseudonym == null
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          CustomIconWidget(
                            iconName: 'edit',
                            color: AppTheme.textTertiary,
                            size: 3.5.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onSelectAvatar,
                  icon: CustomIconWidget(
                    iconName: 'face',
                    color: AppTheme.textPrimary,
                    size: 4.w,
                  ),
                  label: Text(
                    'Avatar',
                    style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentPurple,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEditPseudonym,
                  icon: CustomIconWidget(
                    iconName: 'edit',
                    color: AppTheme.accentPurple,
                    size: 4.w,
                  ),
                  label: Text(
                    'Pseudonym',
                    style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.accentPurple,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
