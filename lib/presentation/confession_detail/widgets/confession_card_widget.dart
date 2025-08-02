import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class ConfessionCardWidget extends StatelessWidget {
  final Map<String, dynamic> confession;
  final VoidCallback? onReaction;

  const ConfessionCardWidget({
    super.key,
    required this.confession,
    this.onReaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.all(4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 3.h),
          _buildContent(context),
          SizedBox(height: 3.h),
          _buildReactionBar(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'person',
              color: colorScheme.primary,
              size: 5.w,
            ),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                confession['userId'] as String? ?? 'Anonymous User',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 0.5.h),
              Text(
                _formatTimestamp(confession['timestamp']),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: _getCategoryColor(confession['category'])
                .withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            confession['category'] as String? ?? 'General',
            style: theme.textTheme.labelSmall?.copyWith(
              color: _getCategoryColor(confession['category']),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      confession['content'] as String? ?? '',
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
        height: 1.5,
      ),
    );
  }

  Widget _buildReactionBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final reactions = confession['reactions'] as Map<String, dynamic>? ?? {};

    return Row(
      children: [
        _buildReactionButton(
          context,
          'like',
          'thumb_up',
          reactions['like'] as int? ?? 0,
          colorScheme.primary,
        ),
        SizedBox(width: 4.w),
        _buildReactionButton(
          context,
          'hug',
          'favorite',
          reactions['hug'] as int? ?? 0,
          const Color(0xFFE91E63),
        ),
        SizedBox(width: 4.w),
        _buildReactionButton(
          context,
          'support',
          'volunteer_activism',
          reactions['support'] as int? ?? 0,
          const Color(0xFF4CAF50),
        ),
        SizedBox(width: 4.w),
        _buildReactionButton(
          context,
          'same',
          'group',
          reactions['same'] as int? ?? 0,
          const Color(0xFFFF9800),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // TODO: Implement comment scroll
          },
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'chat_bubble_outline',
                color: colorScheme.onSurface.withValues(alpha: 0.6),
                size: 4.w,
              ),
              SizedBox(width: 1.w),
              Text(
                '${confession['commentCount'] as int? ?? 0}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReactionButton(
    BuildContext context,
    String type,
    String iconName,
    int count,
    Color color,
  ) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        if (onReaction != null) {
          onReaction!();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: color,
              size: 4.w,
            ),
            if (count > 0) ...[
              SizedBox(width: 1.w),
              Text(
                count.toString(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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

  Color _getCategoryColor(dynamic category) {
    switch (category as String?) {
      case 'Love':
        return const Color(0xFFE91E63);
      case 'Campus Life':
        return const Color(0xFF2196F3);
      case 'Depression':
        return const Color(0xFF9C27B0);
      case 'Money':
        return const Color(0xFF4CAF50);
      case 'Secrets':
        return const Color(0xFFFF5722);
      default:
        return const Color(0xFF607D8B);
    }
  }
}
