import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Navigation item for bottom bar
enum BottomNavItem {
  feed,
  chatRooms,
  profile,
}

/// Custom bottom navigation bar implementing Empathetic Minimalism design
/// for anonymous confession and mental health support app
class CustomBottomBar extends StatelessWidget {
  final BottomNavItem currentIndex;
  final Function(BottomNavItem) onTap;
  final bool showLabels;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: showLabels ? 65 : 60,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: BottomNavItem.values.map((item) {
              return _buildNavItem(context, item);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, BottomNavItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = currentIndex == item;

    final color = isSelected
        ? colorScheme.primary
        : colorScheme.onSurface.withValues(alpha: 0.6);

    return Expanded(
      child: InkWell(
        onTap: () => _handleNavigation(context, item),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Icon(
                  _getIconData(item, isSelected),
                  color: color,
                  size: 24,
                ),
              ),
              if (showLabels) ...[
                const SizedBox(height: 4),
                Text(
                  _getLabel(item),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                    color: color,
                    letterSpacing: 0.4,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(BottomNavItem item, bool isSelected) {
    switch (item) {
      case BottomNavItem.feed:
        return isSelected ? Icons.home_rounded : Icons.home_outlined;
      case BottomNavItem.chatRooms:
        return isSelected
            ? Icons.chat_bubble_rounded
            : Icons.chat_bubble_outline_rounded;
      case BottomNavItem.profile:
        return isSelected ? Icons.person_rounded : Icons.person_outline_rounded;
    }
  }

  String _getLabel(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.feed:
        return 'Feed';
      case BottomNavItem.chatRooms:
        return 'Rooms';
      case BottomNavItem.profile:
        return 'Profile';
    }
  }

  void _handleNavigation(BuildContext context, BottomNavItem item) {
    if (currentIndex == item) return;

    onTap(item);

    switch (item) {
      case BottomNavItem.feed:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/main-feed',
          (route) => false,
        );
        break;
      case BottomNavItem.chatRooms:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/anonymous-chat-rooms',
          (route) => false,
        );
        break;
      case BottomNavItem.profile:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/user-profile',
          (route) => false,
        );
        break;
    }
  }

  /// Factory constructor for main feed
  factory CustomBottomBar.mainFeed({
    required Function(BottomNavItem) onTap,
  }) {
    return CustomBottomBar(
      currentIndex: BottomNavItem.feed,
      onTap: onTap,
    );
  }

  /// Factory constructor for chat rooms
  factory CustomBottomBar.chatRooms({
    required Function(BottomNavItem) onTap,
  }) {
    return CustomBottomBar(
      currentIndex: BottomNavItem.chatRooms,
      onTap: onTap,
    );
  }

  /// Factory constructor for user profile
  factory CustomBottomBar.userProfile({
    required Function(BottomNavItem) onTap,
  }) {
    return CustomBottomBar(
      currentIndex: BottomNavItem.profile,
      onTap: onTap,
    );
  }
}
