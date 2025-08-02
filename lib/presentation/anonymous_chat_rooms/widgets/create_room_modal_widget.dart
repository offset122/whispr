import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class CreateRoomModalWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onCreateRoom;

  const CreateRoomModalWidget({
    super.key,
    required this.onCreateRoom,
  });

  @override
  State<CreateRoomModalWidget> createState() => _CreateRoomModalWidgetState();
}

class _CreateRoomModalWidgetState extends State<CreateRoomModalWidget> {
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  String _selectedCategory = 'General';
  bool _isPrivate = false;
  bool _allowAnonymous = true;
  int _maxParticipants = 50;

  final List<String> _categories = [
    'General',
    'Love',
    'Campus Life',
    'Depression',
    'Money',
    'Secrets',
    'Career',
    'Family',
    'Health',
    'Relationships'
  ];

  @override
  void dispose() {
    _roomNameController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 85.h,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Row(
              children: [
                Text(
                  'Create New Room',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.h),
                  _buildSectionTitle('Room Details'),
                  SizedBox(height: 1.h),
                  _buildTextField(
                    controller: _roomNameController,
                    label: 'Room Name',
                    hint: 'Enter a welcoming room name',
                    maxLength: 50,
                  ),
                  SizedBox(height: 2.h),
                  _buildTextField(
                    controller: _topicController,
                    label: 'Topic (Optional)',
                    hint: 'What will you discuss?',
                    maxLines: 3,
                    maxLength: 200,
                  ),
                  SizedBox(height: 2.h),
                  _buildSectionTitle('Category'),
                  SizedBox(height: 1.h),
                  _buildCategorySelector(),
                  SizedBox(height: 2.h),
                  _buildSectionTitle('Room Settings'),
                  SizedBox(height: 1.h),
                  _buildSettingsSection(),
                  SizedBox(height: 3.h),
                  _buildCreateButton(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        SizedBox(height: 0.5.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hint,
            counterText: maxLength != null ? null : '',
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Wrap(
      spacing: 2.w,
      runSpacing: 1.h,
      children: _categories.map((category) {
        final isSelected = _selectedCategory == category;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedCategory = category;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.accentPurple.withValues(alpha: 0.2)
                  : Theme.of(context)
                      .colorScheme
                      .surface
                      .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppTheme.accentPurple
                    : Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              category,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? AppTheme.accentPurple
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.8),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSettingsSection() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        _buildSwitchTile(
          title: 'Private Room',
          subtitle: 'Require approval to join',
          value: _isPrivate,
          onChanged: (value) {
            setState(() {
              _isPrivate = value;
            });
          },
        ),
        _buildSwitchTile(
          title: 'Allow Anonymous Users',
          subtitle: 'Let users join without profiles',
          value: _allowAnonymous,
          onChanged: (value) {
            setState(() {
              _allowAnonymous = value;
            });
          },
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max Participants',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Current: $_maxParticipants',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 40.w,
              child: Slider(
                value: _maxParticipants.toDouble(),
                min: 10,
                max: 100,
                divisions: 9,
                onChanged: (value) {
                  setState(() {
                    _maxParticipants = value.round();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _canCreateRoom() ? _handleCreateRoom : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
        ),
        child: Text(
          'Create Room',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }

  bool _canCreateRoom() {
    return _roomNameController.text.trim().isNotEmpty;
  }

  void _handleCreateRoom() {
    if (!_canCreateRoom()) return;

    final roomData = {
      'roomName': _roomNameController.text.trim(),
      'topic': _topicController.text.trim(),
      'category': _selectedCategory,
      'isPrivate': _isPrivate,
      'allowAnonymous': _allowAnonymous,
      'maxParticipants': _maxParticipants,
      'createdAt': DateTime.now(),
      'participantCount': 1,
      'isActive': true,
      'lastActivity': DateTime.now(),
      'isBookmarked': false,
      'hasUnreadMessages': false,
      'unreadCount': 0,
      'lastMessage': '',
    };

    widget.onCreateRoom(roomData);
    Navigator.pop(context);
  }
}
