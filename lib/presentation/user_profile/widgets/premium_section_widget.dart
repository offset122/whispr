import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PremiumSectionWidget extends StatelessWidget {
  final bool isAdFreeSubscribed;
  final bool isTrendingSubscribed;
  final bool hasVipBadge;
  final VoidCallback onUpgradeAdFree;
  final VoidCallback onUpgradeTrending;
  final VoidCallback onUpgradeVip;

  const PremiumSectionWidget({
    super.key,
    required this.isAdFreeSubscribed,
    required this.isTrendingSubscribed,
    required this.hasVipBadge,
    required this.onUpgradeAdFree,
    required this.onUpgradeTrending,
    required this.onUpgradeVip,
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
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'star',
                  color: AppTheme.warningAmber,
                  size: 6.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Premium Features',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _buildPremiumTile(
            'Ad-Free Experience',
            'Remove all advertisements',
            'Ksh 100/month',
            'block',
            isAdFreeSubscribed,
            onUpgradeAdFree,
          ),
          _buildDivider(),
          _buildPremiumTile(
            'Trending Content',
            'Access to trending confessions',
            'Ksh 50',
            'trending_up',
            isTrendingSubscribed,
            onUpgradeTrending,
          ),
          _buildDivider(),
          _buildPremiumTile(
            'VIP Badge',
            'Priority for your posts',
            'Premium feature',
            'verified',
            hasVipBadge,
            onUpgradeVip,
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumTile(
    String title,
    String description,
    String price,
    String iconName,
    bool isSubscribed,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: isSubscribed ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: isSubscribed
                    ? AppTheme.supportTeal.withValues(alpha: 0.2)
                    : AppTheme.warningAmber.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: CustomIconWidget(
                iconName: isSubscribed ? 'check_circle' : iconName,
                color:
                    isSubscribed ? AppTheme.supportTeal : AppTheme.warningAmber,
                size: 5.w,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isSubscribed) ...[
                        SizedBox(width: 2.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.supportTeal.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Text(
                            'Active',
                            style: AppTheme.darkTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.supportTeal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    description,
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (!isSubscribed) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.warningAmber,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  CustomIconWidget(
                    iconName: 'chevron_right',
                    color: AppTheme.textTertiary,
                    size: 4.w,
                  ),
                ],
              ),
            ],
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
