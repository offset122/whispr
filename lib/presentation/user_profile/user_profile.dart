import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/account_section_widget.dart';
import './widgets/avatar_marketplace_widget.dart';
import './widgets/help_section_widget.dart';
import './widgets/premium_section_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/profile_stats_widget.dart';
import './widgets/settings_section_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // Mock user data
  String anonymousId = "User #12847";
  String? pseudonym = "GhostWhisperer";
  String? avatarUrl =
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150&h=150&fit=crop&crop=face";

  // Stats data
  int confessionsPosted = 23;
  int commentsMade = 156;
  int reactionsReceived = 892;
  int karmaScore = 1247;

  // Settings data
  bool isDarkMode = true;
  bool notificationsEnabled = true;
  String contentFilter = "Moderate";
  String language = "English";

  // Premium data
  bool isAdFreeSubscribed = false;
  bool isTrendingSubscribed = true;
  bool hasVipBadge = false;

  // Account data
  bool biometricEnabled = false;
  int blockedUsersCount = 3;
  int bookmarkedCount = 47;

  // Avatar marketplace data
  final List<Map<String, dynamic>> avatarMarketplace = [
    {
      "id": "1",
      "name": "Ghost",
      "imageUrl":
          "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=150&h=150&fit=crop",
      "price": "Ksh 50",
      "isPurchased": true,
    },
    {
      "id": "2",
      "name": "Shadow",
      "imageUrl":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
      "price": "Ksh 75",
      "isPurchased": false,
    },
    {
      "id": "3",
      "name": "Phantom",
      "imageUrl":
          "https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face",
      "price": "Ksh 100",
      "isPurchased": true,
    },
    {
      "id": "4",
      "name": "Mystic",
      "imageUrl":
          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
      "price": "Ksh 60",
      "isPurchased": false,
    },
    {
      "id": "5",
      "name": "Whisper",
      "imageUrl":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face",
      "price": "Ksh 80",
      "isPurchased": false,
    },
    {
      "id": "6",
      "name": "Spirit",
      "imageUrl":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face",
      "price": "Ksh 90",
      "isPurchased": true,
    },
  ];

  String? selectedAvatarId = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: CustomAppBar.userProfile(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              // Profile Header
              ProfileHeaderWidget(
                anonymousId: anonymousId,
                pseudonym: pseudonym,
                avatarUrl: avatarUrl,
                onRegenerateId: _regenerateAnonymousId,
                onEditPseudonym: _editPseudonym,
                onSelectAvatar: _showAvatarMarketplace,
              ),
              SizedBox(height: 3.h),

              // Profile Stats
              ProfileStatsWidget(
                confessionsPosted: confessionsPosted,
                commentsMade: commentsMade,
                reactionsReceived: reactionsReceived,
                karmaScore: karmaScore,
              ),
              SizedBox(height: 3.h),

              // Settings Section
              SettingsSectionWidget(
                isDarkMode: isDarkMode,
                notificationsEnabled: notificationsEnabled,
                contentFilter: contentFilter,
                language: language,
                onDarkModeChanged: _toggleDarkMode,
                onNotificationsChanged: _toggleNotifications,
                onContentFilterTap: _showContentFilterOptions,
                onLanguageTap: _showLanguageOptions,
              ),
              SizedBox(height: 3.h),

              // Premium Section
              PremiumSectionWidget(
                isAdFreeSubscribed: isAdFreeSubscribed,
                isTrendingSubscribed: isTrendingSubscribed,
                hasVipBadge: hasVipBadge,
                onUpgradeAdFree: _upgradeAdFree,
                onUpgradeTrending: _upgradeTrending,
                onUpgradeVip: _upgradeVip,
              ),
              SizedBox(height: 3.h),

              // Avatar Marketplace
              AvatarMarketplaceWidget(
                avatars: avatarMarketplace,
                selectedAvatarId: selectedAvatarId,
                onAvatarSelected: _selectAvatar,
                onAvatarPurchase: _purchaseAvatar,
              ),
              SizedBox(height: 3.h),

              // Account Section
              AccountSectionWidget(
                biometricEnabled: biometricEnabled,
                blockedUsersCount: blockedUsersCount,
                bookmarkedCount: bookmarkedCount,
                onBiometricChanged: _toggleBiometric,
                onPrivacySettingsTap: _openPrivacySettings,
                onBlockedUsersTap: _openBlockedUsers,
                onBookmarksTap: _openBookmarks,
                onDataExportTap: _exportData,
              ),
              SizedBox(height: 3.h),

              // Help Section
              HelpSectionWidget(
                onGuidelinesTap: _openGuidelines,
                onMentalHealthTap: _openMentalHealthResources,
                onSupportTap: _contactSupport,
                onAboutTap: _showAbout,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar.userProfile(
        onTap: _handleBottomNavigation,
      ),
    );
  }

  void _regenerateAnonymousId() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.dialogColor,
        title: Text(
          'Regenerate Anonymous ID',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'This will generate a new anonymous ID. Your previous confessions will remain but with the new ID. Continue?',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                anonymousId =
                    "User #${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Anonymous ID regenerated successfully'),
                  backgroundColor: AppTheme.supportTeal,
                ),
              );
            },
            child: Text('Regenerate'),
          ),
        ],
      ),
    );
  }

  void _editPseudonym() {
    final TextEditingController controller =
        TextEditingController(text: pseudonym ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.dialogColor,
        title: Text(
          'Edit Pseudonym',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            hintText: 'Enter pseudonym (optional)',
            hintStyle: TextStyle(color: AppTheme.textTertiary),
          ),
          maxLength: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                pseudonym = controller.text.trim().isEmpty
                    ? null
                    : controller.text.trim();
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAvatarMarketplace() {
    // This would typically open a full-screen avatar selection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Scroll down to see the Avatar Marketplace'),
        backgroundColor: AppTheme.accentPurple,
      ),
    );
  }

  void _selectAvatar(String avatarId) {
    final avatar = avatarMarketplace.firstWhere((a) => a['id'] == avatarId);
    setState(() {
      selectedAvatarId = avatarId;
      avatarUrl = avatar['imageUrl'] as String;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Avatar selected: ${avatar['name']}'),
        backgroundColor: AppTheme.supportTeal,
      ),
    );
  }

  void _purchaseAvatar(String avatarId) {
    final avatar = avatarMarketplace.firstWhere((a) => a['id'] == avatarId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.dialogColor,
        title: Text(
          'Purchase Avatar',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.darkTheme.colorScheme.secondaryContainer,
              ),
              child: ClipOval(
                child: CustomImageWidget(
                  imageUrl: avatar['imageUrl'] as String,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Purchase ${avatar['name']} avatar for ${avatar['price']}?',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index =
                    avatarMarketplace.indexWhere((a) => a['id'] == avatarId);
                avatarMarketplace[index]['isPurchased'] = true;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Avatar purchased successfully!'),
                  backgroundColor: AppTheme.supportTeal,
                ),
              );
            },
            child: Text('Purchase'),
          ),
        ],
      ),
    );
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
    });
  }

  void _showContentFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10.w,
              height: 1.h,
              margin: EdgeInsets.only(top: 2.h, bottom: 3.h),
              decoration: BoxDecoration(
                color: AppTheme.textTertiary,
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
            Text(
              'Content Filter',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ...['Strict', 'Moderate', 'Relaxed'].map((filter) => ListTile(
                  title: Text(
                    filter,
                    style: TextStyle(color: AppTheme.textPrimary),
                  ),
                  trailing: contentFilter == filter
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: AppTheme.accentPurple,
                          size: 5.w,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      contentFilter = filter;
                    });
                    Navigator.pop(context);
                  },
                )),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  void _showLanguageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.darkTheme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10.w,
              height: 1.h,
              margin: EdgeInsets.only(top: 2.h, bottom: 3.h),
              decoration: BoxDecoration(
                color: AppTheme.textTertiary,
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
            Text(
              'Language',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ...['English', 'Swahili'].map((lang) => ListTile(
                  title: Text(
                    lang,
                    style: TextStyle(color: AppTheme.textPrimary),
                  ),
                  trailing: language == lang
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: AppTheme.accentPurple,
                          size: 5.w,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      language = lang;
                    });
                    Navigator.pop(context);
                  },
                )),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  void _upgradeAdFree() {
    _showPremiumUpgrade('Ad-Free Experience', 'Ksh 100/month', () {
      setState(() {
        isAdFreeSubscribed = true;
      });
    });
  }

  void _upgradeTrending() {
    _showPremiumUpgrade('Trending Content Access', 'Ksh 50', () {
      setState(() {
        isTrendingSubscribed = true;
      });
    });
  }

  void _upgradeVip() {
    _showPremiumUpgrade('VIP Badge', 'Premium feature', () {
      setState(() {
        hasVipBadge = true;
      });
    });
  }

  void _showPremiumUpgrade(
      String feature, String price, VoidCallback onUpgrade) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.dialogColor,
        title: Text(
          'Upgrade to Premium',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'Upgrade to $feature for $price?\n\nPayment methods:\n• M-Pesa\n• Apple Pay\n• Google Pay',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onUpgrade();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$feature activated successfully!'),
                  backgroundColor: AppTheme.supportTeal,
                ),
              );
            },
            child: Text('Upgrade'),
          ),
        ],
      ),
    );
  }

  void _toggleBiometric(bool value) {
    setState(() {
      biometricEnabled = value;
    });
  }

  void _openPrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Privacy settings would open here'),
        backgroundColor: AppTheme.accentPurple,
      ),
    );
  }

  void _openBlockedUsers() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Blocked users list would open here'),
        backgroundColor: AppTheme.accentPurple,
      ),
    );
  }

  void _openBookmarks() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bookmarked confessions would open here'),
        backgroundColor: AppTheme.accentPurple,
      ),
    );
  }

  void _exportData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.dialogColor,
        title: Text(
          'Export Data',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'Export all your data including confessions, comments, and settings? This may take a few minutes.',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Data export started. You will receive an email when ready.'),
                  backgroundColor: AppTheme.supportTeal,
                ),
              );
            },
            child: Text('Export'),
          ),
        ],
      ),
    );
  }

  void _openGuidelines() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Community guidelines would open here'),
        backgroundColor: AppTheme.supportTeal,
      ),
    );
  }

  void _openMentalHealthResources() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mental health resources would open here'),
        backgroundColor: AppTheme.supportTeal,
      ),
    );
  }

  void _contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Support contact would open here'),
        backgroundColor: AppTheme.supportTeal,
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.dialogColor,
        title: Text(
          'About Whispr',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'Whispr v1.0.0\n\nA safe, anonymous platform for sharing confessions and seeking advice from strangers while maintaining complete privacy.\n\n© 2025 Whispr. All rights reserved.',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _handleBottomNavigation(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        Navigator.pushNamedAndRemoveUntil(
            context, '/main-feed', (route) => false);
        break;
      case BottomNavItem.chatRooms:
        Navigator.pushNamedAndRemoveUntil(
            context, '/anonymous-chat-rooms', (route) => false);
        break;
      case BottomNavItem.profile:
        // Already on profile screen
        break;
    }
  }
}
