import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TopicFilterChipWidget extends StatelessWidget {
  final String topic;
  final bool isSelected;
  final int count;
  final VoidCallback onTap;

  const TopicFilterChipWidget({
    super.key,
    required this.topic,
    required this.isSelected,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final topicColor = _getTopicColor(topic);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 2.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
        decoration: BoxDecoration(
          color: isSelected
              ? topicColor.withValues(alpha: 0.15)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? topicColor.withValues(alpha: 0.3)
                : colorScheme.outline.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: topicColor.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getTopicEmoji(topic),
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(width: 1.5.w),
            Text(
              topic,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? topicColor
                    : colorScheme.onSurface.withValues(alpha: 0.8),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 1.w),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.3.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? topicColor.withValues(alpha: 0.2)
                      : colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count > 99 ? '99+' : count.toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isSelected ? topicColor : colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 9.sp,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getTopicColor(String topic) {
    switch (topic.toLowerCase()) {
      case 'all':
        return AppTheme.accentPurple;
      case 'love':
        return AppTheme.errorRose;
      case 'campus life':
        return AppTheme.accentPurple;
      case 'depression':
        return AppTheme.textSecondary;
      case 'money':
        return AppTheme.warningAmber;
      case 'secrets':
        return AppTheme.supportTeal;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getTopicEmoji(String topic) {
    switch (topic.toLowerCase()) {
      case 'all':
        return '🌟';
      case 'love':
        return '💕';
      case 'campus life':
        return '🎓';
      case 'depression':
        return '🌧️';
      case 'money':
        return '💰';
      case 'secrets':
        return '🤫';
      default:
        return '💭';
    }
  }
}
