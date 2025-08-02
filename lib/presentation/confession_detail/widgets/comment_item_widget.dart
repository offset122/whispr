import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class CommentItemWidget extends StatelessWidget {
  final Map<String, dynamic> comment;
  final int indentLevel;
  final VoidCallback? onReply;
  final VoidCallback? onReport;
  final VoidCallback? onReaction;

  const CommentItemWidget({
    super.key,
    required this.comment,
    this.indentLevel = 0,
    this.onReply,
    this.onReport,
    this.onReaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(
        left: (indentLevel * 4.w).clamp(0, 12.w),
        bottom: 2.h,
      ),
      child: GestureDetector(
        onLongPress: () => _showCommentOptions(context),
        child: Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: indentLevel > 0
                ? colorScheme.surface.withValues(alpha: 0.5)
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: indentLevel > 0
                ? Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCommentHeader(context),
              SizedBox(height: 2.h),
              _buildCommentContent(context),
              SizedBox(height: 2.h),
              _buildCommentActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: colorScheme.secondary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'person',
              color: colorScheme.secondary,
              size: 4.w,
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment['userId'] as String? ?? 'Anonymous User',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                _formatTimestamp(comment['timestamp']),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (indentLevel > 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Reply',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCommentContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      comment['content'] as String? ?? '',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        height: 1.4,
      ),
    );
  }

  Widget _buildCommentActions(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final reactions = comment['reactions'] as Map<String, dynamic>? ?? {};

    return Row(
      children: [
        _buildMiniReactionButton(
          context,
          'like',
          'thumb_up',
          reactions['like'] as int? ?? 0,
          colorScheme.primary,
        ),
        SizedBox(width: 3.w),
        _buildMiniReactionButton(
          context,
          'hug',
          'favorite',
          reactions['hug'] as int? ?? 0,
          const Color(0xFFE91E63),
        ),
        SizedBox(width: 3.w),
        _buildMiniReactionButton(
          context,
          'support',
          'volunteer_activism',
          reactions['support'] as int? ?? 0,
          const Color(0xFF4CAF50),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onReply,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'reply',
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 3.5.w,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Reply',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniReactionButton(
    BuildContext context,
    String type,
    String iconName,
    int count,
    Color color,
  ) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onReaction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: count > 0 ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: count > 0 ? color : color.withValues(alpha: 0.5),
              size: 3.w,
            ),
            if (count > 0) ...[
              SizedBox(width: 0.5.w),
              Text(
                count.toString(),
                style: theme.textTheme.bodySmall?.copyWith(
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

  void _showCommentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'reply',
                color: Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
              title: const Text('Reply to comment'),
              onTap: () {
                Navigator.pop(context);
                if (onReply != null) onReply!();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'report',
                color: Theme.of(context).colorScheme.error,
                size: 24,
              ),
              title: const Text('Report comment'),
              onTap: () {
                Navigator.pop(context);
                if (onReport != null) onReport!();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'block',
                color: Theme.of(context).colorScheme.error,
                size: 24,
              ),
              title: const Text('Block user'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement block user functionality
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Just now';

    try {
      DateTime dateTime;
      if (timestamp is DateTime) {
        dateTime = timestamp;
      } else if (timestamp is String) {
        dateTime = DateTime.parse(timestamp);
      } else {
        return 'Just now';
      }

      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'Just now';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inDays < 1) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
    } catch (e) {
      return 'Just now';
    }
  }
}
