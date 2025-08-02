import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ChatMessageWidget extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isCurrentUser;
  final VoidCallback? onReply;
  final Function(String)? onReact;
  final VoidCallback? onReport;
  final VoidCallback? onBlockUser;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.isCurrentUser,
    this.onReply,
    this.onReact,
    this.onReport,
    this.onBlockUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser) ...[
            _buildAvatar(colorScheme),
            SizedBox(width: 2.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser) _buildSenderInfo(theme),
                GestureDetector(
                  onLongPress: () => _showMessageOptions(context),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 70.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? AppTheme.accentPurple
                          : AppTheme.secondaryDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isCurrentUser ? 16 : 4),
                        topRight: Radius.circular(isCurrentUser ? 4 : 16),
                        bottomLeft: const Radius.circular(16),
                        bottomRight: const Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message['replyTo'] != null)
                          _buildReplyPreview(theme),
                        Text(
                          message['content'] as String,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isCurrentUser
                                ? AppTheme.textPrimary
                                : AppTheme.textPrimary,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatTime(message['timestamp'] as DateTime),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isCurrentUser
                                    ? AppTheme.textPrimary
                                        .withValues(alpha: 0.7)
                                    : AppTheme.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                            if (isCurrentUser && message['status'] != null) ...[
                              SizedBox(width: 1.w),
                              CustomIconWidget(
                                iconName:
                                    _getStatusIcon(message['status'] as String),
                                size: 12,
                                color:
                                    AppTheme.textPrimary.withValues(alpha: 0.7),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (message['reactions'] != null &&
                    (message['reactions'] as List).isNotEmpty)
                  _buildReactions(context),
              ],
            ),
          ),
          if (isCurrentUser) ...[
            SizedBox(width: 2.w),
            _buildAvatar(colorScheme),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: BoxDecoration(
        color: isCurrentUser ? AppTheme.accentPurple : AppTheme.supportTeal,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: 'person',
          size: 16,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSenderInfo(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.5.h, left: 2.w),
      child: Text(
        message['senderName'] as String,
        style: theme.textTheme.bodySmall?.copyWith(
          color: AppTheme.textSecondary,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildReplyPreview(ThemeData theme) {
    final replyTo = message['replyTo'] as Map<String, dynamic>;
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: AppTheme.textPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: AppTheme.supportTeal,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            replyTo['senderName'] as String,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.supportTeal,
              fontSize: 9.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            (replyTo['content'] as String).length > 50
                ? '${(replyTo['content'] as String).substring(0, 50)}...'
                : replyTo['content'] as String,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactions(BuildContext context) {
    final reactions = message['reactions'] as List<Map<String, dynamic>>;
    final groupedReactions = <String, int>{};

    for (final reaction in reactions) {
      final emoji = reaction['emoji'] as String;
      groupedReactions[emoji] = (groupedReactions[emoji] ?? 0) + 1;
    }

    return Container(
      margin: EdgeInsets.only(top: 0.5.h),
      child: Wrap(
        spacing: 1.w,
        children: groupedReactions.entries.map((entry) {
          return GestureDetector(
            onTap: () => onReact?.call(entry.key),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.accentPurple.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  if (entry.value > 1) ...[
                    SizedBox(width: 1.w),
                    Text(
                      entry.value.toString(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                            fontSize: 9.sp,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  String _getStatusIcon(String status) {
    switch (status) {
      case 'sent':
        return 'check';
      case 'delivered':
        return 'done_all';
      case 'read':
        return 'done_all';
      default:
        return 'schedule';
    }
  }

  void _showMessageOptions(BuildContext context) {
    HapticFeedback.mediumImpact();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.dialogColor,
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
                color: AppTheme.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'reply',
                color: AppTheme.textPrimary,
                size: 24,
              ),
              title: Text(
                'Reply',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
              ),
              onTap: () {
                Navigator.pop(context);
                onReply?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'add_reaction',
                color: AppTheme.textPrimary,
                size: 24,
              ),
              title: Text(
                'React',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showEmojiPicker(context);
              },
            ),
            if (!isCurrentUser) ...[
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'report',
                  color: AppTheme.errorRose,
                  size: 24,
                ),
                title: Text(
                  'Report',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.errorRose,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onReport?.call();
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'block',
                  color: AppTheme.errorRose,
                  size: 24,
                ),
                title: Text(
                  'Block User',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.errorRose,
                      ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onBlockUser?.call();
                },
              ),
            ],
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _showEmojiPicker(BuildContext context) {
    final emojis = ['❤️', '👍', '😢', '😊', '🤗', '💪', '🙏', '😮'];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.dialogColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppTheme.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                'React with emoji',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
              ),
              SizedBox(height: 3.h),
              Wrap(
                spacing: 4.w,
                runSpacing: 2.h,
                children: emojis.map((emoji) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onReact?.call(emoji);
                    },
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryDark,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.accentPurple.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          emoji,
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
