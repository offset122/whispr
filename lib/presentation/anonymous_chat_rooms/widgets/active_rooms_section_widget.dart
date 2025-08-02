import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ActiveRoomsSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> activeRooms;
  final Function(Map<String, dynamic>) onRoomTap;

  const ActiveRoomsSectionWidget({
    super.key,
    required this.activeRooms,
    required this.onRoomTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (activeRooms.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'radio_button_checked',
                color: AppTheme.supportTeal,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Currently In',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.supportTeal.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${activeRooms.length}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.supportTeal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 12.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activeRooms.length,
              itemBuilder: (context, index) {
                final room = activeRooms[index];
                return _buildActiveRoomCard(context, room);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRoomCard(BuildContext context, Map<String, dynamic> room) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final roomName = (room['roomName'] as String?) ?? '';
    final participantCount = (room['participantCount'] as int?) ?? 0;
    final category = (room['category'] as String?) ?? '';
    final hasUnreadMessages = (room['hasUnreadMessages'] as bool?) ?? false;
    final unreadCount = (room['unreadCount'] as int?) ?? 0;

    return Container(
      width: 40.w,
      margin: EdgeInsets.only(right: 3.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onRoomTap(room),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.supportTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.supportTeal.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 2.w,
                      height: 2.w,
                      decoration: const BoxDecoration(
                        color: AppTheme.supportTeal,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Spacer(),
                    if (hasUnreadMessages && unreadCount > 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.5.w, vertical: 0.3.h),
                        decoration: BoxDecoration(
                          color: AppTheme.errorRose,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : '$unreadCount',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  roomName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  category,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.supportTeal,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'people_outline',
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '$participantCount',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 10.sp,
                      ),
                    ),
                    const Spacer(),
                    CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      color: AppTheme.supportTeal,
                      size: 12,
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
}
