import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom app bar widget implementing Empathetic Minimalism design
/// for anonymous confession and mental health support app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: foregroundColor ?? colorScheme.onSurface,
          letterSpacing: 0.15,
        ),
      ),
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      foregroundColor: foregroundColor ?? colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: leading ?? (showBackButton ? _buildBackButton(context) : null),
      actions: actions,
      bottom: bottom,
      automaticallyImplyLeading: showBackButton,
    );
  }

  Widget? _buildBackButton(BuildContext context) {
    if (!showBackButton) return null;

    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      tooltip: 'Back',
      splashRadius: 20,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  /// Factory constructor for main feed app bar
  factory CustomAppBar.mainFeed(BuildContext context) {
    return CustomAppBar(
      title: 'Anonymous Confessions',
      showBackButton: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded, size: 24),
          onPressed: () {
            // TODO: Implement search functionality
          },
          tooltip: 'Search',
          splashRadius: 20,
        ),
        IconButton(
          icon: const Icon(Icons.person_outline_rounded, size: 24),
          onPressed: () {
            Navigator.pushNamed(context, '/user-profile');
          },
          tooltip: 'Profile',
          splashRadius: 20,
        ),
      ],
    );
  }

  /// Factory constructor for confession detail app bar
  factory CustomAppBar.confessionDetail(BuildContext context) {
    return CustomAppBar(
      title: 'Confession',
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded, size: 24),
          onPressed: () {
            _showConfessionOptions(context);
          },
          tooltip: 'More options',
          splashRadius: 20,
        ),
      ],
    );
  }

  /// Factory constructor for chat rooms app bar
  factory CustomAppBar.chatRooms(BuildContext context) {
    return CustomAppBar(
      title: 'Support Rooms',
      actions: [
        IconButton(
          icon: const Icon(Icons.add_rounded, size: 24),
          onPressed: () {
            // TODO: Implement create room functionality
          },
          tooltip: 'Create room',
          splashRadius: 20,
        ),
        IconButton(
          icon: const Icon(Icons.filter_list_rounded, size: 24),
          onPressed: () {
            // TODO: Implement filter functionality
          },
          tooltip: 'Filter',
          splashRadius: 20,
        ),
      ],
    );
  }

  /// Factory constructor for live chat app bar
  factory CustomAppBar.liveChat(BuildContext context, String roomName) {
    return CustomAppBar(
      title: roomName,
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline_rounded, size: 24),
          onPressed: () {
            // TODO: Implement room info functionality
          },
          tooltip: 'Room info',
          splashRadius: 20,
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_rounded, size: 24),
          onPressed: () {
            _showChatOptions(context);
          },
          tooltip: 'More options',
          splashRadius: 20,
        ),
      ],
    );
  }

  /// Factory constructor for user profile app bar
  factory CustomAppBar.userProfile(BuildContext context) {
    return CustomAppBar(
      title: 'Profile',
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, size: 24),
          onPressed: () {
            // TODO: Implement settings functionality
          },
          tooltip: 'Settings',
          splashRadius: 20,
        ),
      ],
    );
  }

  /// Show confession options bottom sheet
  static void _showConfessionOptions(BuildContext context) {
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
              leading: const Icon(Icons.bookmark_outline_rounded),
              title: const Text('Save confession'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement save functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('Report'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement report functionality
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Show chat options bottom sheet
  static void _showChatOptions(BuildContext context) {
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
              leading: const Icon(Icons.volume_off_outlined),
              title: const Text('Mute notifications'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement mute functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Leave room'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement leave room functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: const Text('Report room'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement report functionality
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
