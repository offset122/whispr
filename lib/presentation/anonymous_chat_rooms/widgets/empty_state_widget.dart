import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onCreateRoom;

  const EmptyStateWidget({
    super.key,
    required this.onCreateRoom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.5),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: CustomIconWidget(
                iconName: 'chat_bubble_outline',
                color: colorScheme.onSurface.withValues(alpha: 0.4),
                size: 15.w,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'No Chat Rooms Yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Be the first to create a supportive space for anonymous conversations and advice sharing.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            _buildSuggestedTopics(context),
            SizedBox(height: 4.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCreateRoom,
                icon: CustomIconWidget(
                  iconName: 'add',
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  'Create Your First Room',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedTopics(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final suggestedTopics = [
      {
        'title': 'Love & Relationships',
        'icon': 'favorite_outline',
        'color': AppTheme.errorRose
      },
      {
        'title': 'Campus Life',
        'icon': 'school_outlined',
        'color': AppTheme.accentPurple
      },
      {
        'title': 'Mental Health',
        'icon': 'psychology_outlined',
        'color': AppTheme.supportTeal
      },
      {
        'title': 'Career Advice',
        'icon': 'work_outline',
        'color': AppTheme.warningAmber
      },
    ];

    return Column(
      children: [
        Text(
          'Popular Topics',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        SizedBox(height: 1.5.h),
        Wrap(
          spacing: 3.w,
          runSpacing: 1.h,
          alignment: WrapAlignment.center,
          children: suggestedTopics.map((topic) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: (topic['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (topic['color'] as Color).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: topic['icon'] as String,
                    color: topic['color'] as Color,
                    size: 16,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    topic['title'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: topic['color'] as Color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
