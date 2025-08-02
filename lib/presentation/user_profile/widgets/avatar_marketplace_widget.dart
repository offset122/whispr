import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AvatarMarketplaceWidget extends StatelessWidget {
  final List<Map<String, dynamic>> avatars;
  final String? selectedAvatarId;
  final Function(String) onAvatarSelected;
  final Function(String) onAvatarPurchase;

  const AvatarMarketplaceWidget({
    super.key,
    required this.avatars,
    this.selectedAvatarId,
    required this.onAvatarSelected,
    required this.onAvatarPurchase,
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
                  iconName: 'face',
                  color: AppTheme.accentPurple,
                  size: 6.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Avatar Marketplace',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 25.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 2.w,
                mainAxisSpacing: 2.w,
              ),
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                final avatar = avatars[index];
                return _buildAvatarItem(avatar);
              },
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildAvatarItem(Map<String, dynamic> avatar) {
    final String id = avatar['id'] as String;
    final String imageUrl = avatar['imageUrl'] as String;
    final String name = avatar['name'] as String;
    final String price = avatar['price'] as String;
    final bool isPurchased = avatar['isPurchased'] as bool;
    final bool isSelected = selectedAvatarId == id;

    return GestureDetector(
      onTap: () {
        if (isPurchased) {
          onAvatarSelected(id);
        } else {
          onAvatarPurchase(id);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(
            color: isSelected
                ? AppTheme.accentPurple
                : AppTheme.darkTheme.colorScheme.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.darkTheme.colorScheme.secondaryContainer,
                  ),
                  child: ClipOval(
                    child: CustomImageWidget(
                      imageUrl: imageUrl,
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 4.w,
                      height: 4.w,
                      decoration: BoxDecoration(
                        color: AppTheme.accentPurple,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.darkTheme.colorScheme.surface,
                          width: 1,
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.textPrimary,
                        size: 2.5.w,
                      ),
                    ),
                  ),
                if (!isPurchased)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(0.5.w),
                      decoration: BoxDecoration(
                        color: AppTheme.warningAmber,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.darkTheme.colorScheme.surface,
                          width: 1,
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: 'lock',
                        color: AppTheme.primaryDark,
                        size: 2.5.w,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              name,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 0.5.h),
            Text(
              isPurchased ? 'Owned' : price,
              style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                color:
                    isPurchased ? AppTheme.supportTeal : AppTheme.warningAmber,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
