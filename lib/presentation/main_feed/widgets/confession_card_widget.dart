import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ConfessionCardWidget extends StatelessWidget {
  final Map<String, dynamic> confession;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Function(String)? onReaction;

  const ConfessionCardWidget({
    super.key,
    required this.confession,
    this.onTap,
    this.onLongPress,
    this.onReaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 2.h),
                _buildContent(context),
                SizedBox(height: 2.h),
                _buildReactionBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final userId = confession['userId'] as String? ?? 'User #000';
    final timestamp = confession['timestamp'] as DateTime? ?? DateTime.now();
    final topic = confession['topic'] as String? ?? 'General';

    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            userId,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            color: _getTopicColor(topic).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            topic,
            style: theme.textTheme.labelSmall?.copyWith(
              color: _getTopicColor(topic),
              fontSize: 10.sp,
            ),
          ),
        ),
        const Spacer(),
        Text(
          _formatTimestamp(timestamp),
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final content = confession['content'] as String? ?? '';

    return Text(
      content,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        height: 1.5,
        letterSpacing: 0.2,
      ),
      maxLines: 8,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildReactionBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final reactions = confession['reactions'] as Map<String, dynamic>? ?? {};
    final likeCount = reactions['like'] as int? ?? 0;
    final hugCount = reactions['hug'] as int? ?? 0;
    final supportCount = reactions['support'] as int? ?? 0;
    final sameHereCount = reactions['sameHere'] as int? ?? 0;

    return Row(
      children: [
        _buildReactionButton(
          context,
          'like',
          '👍',
          likeCount,
          AppTheme.supportTeal,
        ),
        SizedBox(width: 3.w),
        _buildReactionButton(
          context,
          'hug',
          '🤗',
          hugCount,
          AppTheme.warningAmber,
        ),
        SizedBox(width: 3.w),
        _buildReactionButton(
          context,
          'support',
          '💪',
          supportCount,
          AppTheme.accentPurple,
        ),
        SizedBox(width: 3.w),
        _buildReactionButton(
          context,
          'sameHere',
          '🙋',
          sameHereCount,
          AppTheme.errorRose,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to confession detail
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'chat_bubble_outline',
                  size: 16,
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                SizedBox(width: 1.w),
                Text(
                  '${confession['commentCount'] ?? 0}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReactionButton(
    BuildContext context,
    String reactionType,
    String emoji,
    int count,
    Color color,
  ) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onReaction?.call(reactionType),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 12.sp),
            ),
            if (count > 0) ...[
              SizedBox(width: 1.w),
              Text(
                count.toString(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
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

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
