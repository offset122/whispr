import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class RoomCardWidget extends StatelessWidget {
  final Map<String, dynamic> roomData;
  final VoidCallback onTap;
  final VoidCallback onBookmark;
  final VoidCallback onReport;
  final VoidCallback onBlock;

  const RoomCardWidget({
    super.key,
    required this.roomData,
    required this.onTap,
    required this.onBookmark,
    required this.onReport,
    required this.onBlock,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isActive = (roomData['isActive'] as bool?) ?? false;
    final participantCount = (roomData['participantCount'] as int?) ?? 0;
    final lastMessage = (roomData['lastMessage'] as String?) ?? '';
    final topic = (roomData['topic'] as String?) ?? '';
    final roomName = (roomData['roomName'] as String?) ?? '';
    final category = (roomData['category'] as String?) ?? '';
    final isBookmarked = (roomData['isBookmarked'] as bool?) ?? false;
    final lastActivity =
        (roomData['lastActivity'] as DateTime?) ?? DateTime.now();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: () => _showContextMenu(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive
                    ? AppTheme.supportTeal.withValues(alpha: 0.3)
                    : colorScheme.outline.withValues(alpha: 0.1),
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color:
                            _getCategoryColor(category).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: _getCategoryColor(category),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (isBookmarked)
                      CustomIconWidget(
                        iconName: 'bookmark',
                        color: AppTheme.warningAmber,
                        size: 16,
                      ),
                    SizedBox(width: 2.w),
                    Container(
                      width: 2.w,
                      height: 2.w,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.supportTeal
                            : AppTheme.textTertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h),
                Text(
                  roomName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (topic.isNotEmpty) ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    topic,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: 1.h),
                if (lastMessage.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      lastMessage,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.8),
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                SizedBox(height: 1.5.h),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'people_outline',
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '$participantCount ${participantCount == 1 ? 'person' : 'people'}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _formatLastActivity(lastActivity),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.supportTeal.withValues(alpha: 0.2)
                            : AppTheme.textTertiary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isActive ? 'Active' : 'Quiet',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isActive
                              ? AppTheme.supportTeal
                              : AppTheme.textTertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
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

  String _formatLastActivity(DateTime lastActivity) {
    final now = DateTime.now();
    final difference = now.difference(lastActivity);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _showContextMenu(BuildContext context) {
    final isBookmarked = (roomData['isBookmarked'] as bool?) ?? false;
    
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
                iconName: isBookmarked ? 'bookmark' : 'bookmark_outline',
                color: Theme.of(context).colorScheme.onSurface,
                size: 24,
              ),
              title: Text(isBookmarked ? 'Remove Bookmark' : 'Bookmark Room'),
              onTap: () {
                Navigator.pop(context);
                onBookmark();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'report_outlined',
                color: AppTheme.errorRose,
                size: 24,
              ),
              title: const Text('Report Room'),
              onTap: () {
                Navigator.pop(context);
                onReport();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'block',
                color: AppTheme.errorRose,
                size: 24,
              ),
              title: const Text('Block Room'),
              onTap: () {
                Navigator.pop(context);
                onBlock();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}