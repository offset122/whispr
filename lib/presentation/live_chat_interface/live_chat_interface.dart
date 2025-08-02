import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/chat_header_widget.dart';
import './widgets/chat_input_widget.dart';
import './widgets/chat_message_widget.dart';
import './widgets/participant_list_widget.dart';
import './widgets/typing_indicator_widget.dart';

class LiveChatInterface extends StatefulWidget {
  const LiveChatInterface({super.key});

  @override
  State<LiveChatInterface> createState() => _LiveChatInterfaceState();
}

class _LiveChatInterfaceState extends State<LiveChatInterface>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];
  final List<String> _typingUsers = [];
  final List<Map<String, dynamic>> _participants = [];
  Map<String, dynamic>? _replyingTo;
  bool _isConnected = true;
  bool _autoScroll = true;
  String _currentUserId = 'user_001';

  @override
  void initState() {
    super.initState();
    _initializeMockData();
    _scrollController.addListener(_onScroll);

    // Simulate real-time updates
    _simulateRealTimeUpdates();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeMockData() {
    // Mock room data
    final roomData = {
      "roomId": "room_depression_support_001",
      "topic": "Depression Support Group",
      "participantCount": 12,
      "createdAt": DateTime.now().subtract(const Duration(hours: 2)),
    };

    // Mock participants
    _participants.addAll([
      {
        "id": "user_001",
        "name": "User #001",
        "isOnline": true,
        "isCurrentUser": true,
        "joinedAt": DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        "id": "user_045",
        "name": "User #045",
        "isOnline": true,
        "isCurrentUser": false,
        "joinedAt":
            DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        "lastSeen": DateTime.now().subtract(const Duration(minutes: 5)),
      },
      {
        "id": "user_123",
        "name": "User #123",
        "isOnline": true,
        "isCurrentUser": false,
        "joinedAt": DateTime.now().subtract(const Duration(minutes: 45)),
      },
      {
        "id": "user_089",
        "name": "User #089",
        "isOnline": false,
        "isCurrentUser": false,
        "joinedAt": DateTime.now().subtract(const Duration(hours: 1)),
        "lastSeen": DateTime.now().subtract(const Duration(minutes: 15)),
      },
      {
        "id": "user_156",
        "name": "User #156",
        "isOnline": true,
        "isCurrentUser": false,
        "joinedAt": DateTime.now().subtract(const Duration(minutes: 20)),
      },
    ]);

    // Mock messages
    _messages.addAll([
      {
        "id": "msg_001",
        "senderId": "user_045",
        "senderName": "User #045",
        "content":
            "Hey everyone, I've been struggling with motivation lately. Anyone else feeling this way?",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 45)),
        "status": "delivered",
        "reactions": [
          {"userId": "user_123", "emoji": "🤗"},
          {"userId": "user_001", "emoji": "❤️"},
        ],
      },
      {
        "id": "msg_002",
        "senderId": "user_123",
        "senderName": "User #123",
        "content":
            "I totally understand. Some days it's really hard to get out of bed. You're not alone in this.",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 43)),
        "status": "delivered",
        "replyTo": {
          "messageId": "msg_001",
          "senderName": "User #045",
          "content":
              "Hey everyone, I've been struggling with motivation lately. Anyone else feeling this way?",
        },
        "reactions": [
          {"userId": "user_045", "emoji": "🙏"},
          {"userId": "user_001", "emoji": "💪"},
        ],
      },
      {
        "id": "msg_003",
        "senderId": "user_001",
        "senderName": "User #001",
        "content":
            "Thank you both for sharing. It helps to know we're all going through similar things. Small steps, right?",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 40)),
        "status": "read",
        "reactions": [
          {"userId": "user_045", "emoji": "👍"},
          {"userId": "user_123", "emoji": "❤️"},
          {"userId": "user_156", "emoji": "🤗"},
        ],
      },
      {
        "id": "msg_004",
        "senderId": "user_156",
        "senderName": "User #156",
        "content":
            "Exactly! I started with just making my bed every morning. It's amazing how such a small thing can make you feel accomplished.",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 38)),
        "status": "delivered",
        "reactions": [
          {"userId": "user_001", "emoji": "💪"},
          {"userId": "user_123", "emoji": "😊"},
        ],
      },
      {
        "id": "msg_005",
        "senderId": "user_089",
        "senderName": "User #089",
        "content":
            "That's a great tip! I'm going to try that tomorrow. Thanks for the encouragement everyone 💙",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 35)),
        "status": "delivered",
        "reactions": [
          {"userId": "user_156", "emoji": "🙏"},
          {"userId": "user_001", "emoji": "❤️"},
        ],
      },
      {
        "id": "msg_006",
        "senderId": "user_045",
        "senderName": "User #045",
        "content":
            "This community is so supportive. I'm feeling a bit better already just from talking to you all.",
        "timestamp": DateTime.now().subtract(const Duration(minutes: 30)),
        "status": "delivered",
        "reactions": [
          {"userId": "user_001", "emoji": "🤗"},
          {"userId": "user_123", "emoji": "❤️"},
          {"userId": "user_156", "emoji": "😊"},
        ],
      },
    ]);

    // Auto-scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollToBottom();
      }
    });
  }

  void _simulateRealTimeUpdates() {
    // Simulate typing indicators
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _typingUsers.add("User #123");
        });

        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              _typingUsers.clear();
            });
            _addNewMessage({
              "id": "msg_${DateTime.now().millisecondsSinceEpoch}",
              "senderId": "user_123",
              "senderName": "User #123",
              "content": "How is everyone doing today? 😊",
              "timestamp": DateTime.now(),
              "status": "delivered",
              "reactions": [],
            });
          }
        });
      }
    });
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final isAtBottom = _scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100;

      if (_autoScroll != isAtBottom) {
        setState(() {
          _autoScroll = isAtBottom;
        });
      }
    }
  }

  void _scrollToBottom({bool animate = true}) {
    if (_scrollController.hasClients) {
      if (animate) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  void _addNewMessage(Map<String, dynamic> message) {
    setState(() {
      _messages.add(message);
    });

    if (_autoScroll) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _sendMessage(String content) {
    final message = {
      "id": "msg_${DateTime.now().millisecondsSinceEpoch}",
      "senderId": _currentUserId,
      "senderName": "User #001",
      "content": content,
      "timestamp": DateTime.now(),
      "status": "sent",
      "reactions": <Map<String, dynamic>>[],
      if (_replyingTo != null) "replyTo": _replyingTo,
    };

    _addNewMessage(message);

    // Clear reply
    if (_replyingTo != null) {
      setState(() {
        _replyingTo = null;
      });
    }

    // Simulate message status updates
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        final messageIndex =
            _messages.indexWhere((m) => m['id'] == message['id']);
        if (messageIndex != -1) {
          setState(() {
            _messages[messageIndex]['status'] = 'delivered';
          });
        }
      }
    });
  }

  void _replyToMessage(Map<String, dynamic> message) {
    setState(() {
      _replyingTo = {
        "messageId": message['id'],
        "senderName": message['senderName'],
        "content": message['content'],
      };
    });
  }

  void _reactToMessage(String messageId, String emoji) {
    final messageIndex = _messages.indexWhere((m) => m['id'] == messageId);
    if (messageIndex != -1) {
      setState(() {
        final reactions =
            _messages[messageIndex]['reactions'] as List<Map<String, dynamic>>;

        // Remove existing reaction from current user
        reactions.removeWhere((r) => r['userId'] == _currentUserId);

        // Add new reaction
        reactions.add({
          "userId": _currentUserId,
          "emoji": emoji,
        });
      });
    }

    HapticFeedback.lightImpact();
  }

  void _blockUser(String userId) {
    // Remove user from participants
    setState(() {
      _participants.removeWhere((p) => p['id'] == userId);
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User blocked successfully'),
        backgroundColor: AppTheme.errorRose,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showRoomOptions() {
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
                iconName: 'info',
                color: AppTheme.textPrimary,
                size: 24,
              ),
              title: Text(
                'Room Info',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show room info
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'volume_off',
                color: AppTheme.textPrimary,
                size: 24,
              ),
              title: Text(
                'Mute Notifications',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textPrimary,
                    ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Mute notifications
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'exit_to_app',
                color: AppTheme.errorRose,
                size: 24,
              ),
              title: Text(
                'Leave Room',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.errorRose,
                    ),
              ),
              onTap: () {
                Navigator.pop(context);
                _leaveRoom();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'report',
                color: AppTheme.errorRose,
                size: 24,
              ),
              title: Text(
                'Report Room',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.errorRose,
                    ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Report room
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  void _showParticipants() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => ParticipantListWidget(
          participants: _participants,
          onBlockUser: _blockUser,
        ),
      ),
    );
  }

  void _leaveRoom() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.dialogColor,
        title: Text(
          'Leave Room',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
              ),
        ),
        content: Text(
          'Are you sure you want to leave this support room?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/anonymous-chat-rooms',
                (route) => false,
              );
            },
            child: Text(
              'Leave',
              style: TextStyle(color: AppTheme.errorRose),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshMessages() async {
    // Simulate loading older messages
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      final olderMessages = [
        {
          "id": "msg_old_001",
          "senderId": "user_045",
          "senderName": "User #045",
          "content":
              "Welcome to the Depression Support Group. This is a safe space for everyone.",
          "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
          "status": "delivered",
          "reactions": [
            {"userId": "user_001", "emoji": "❤️"},
            {"userId": "user_123", "emoji": "🙏"},
          ],
        },
        {
          "id": "msg_old_002",
          "senderId": "user_123",
          "senderName": "User #123",
          "content":
              "Thank you for creating this space. It means a lot to have somewhere to talk openly.",
          "timestamp":
              DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
          "status": "delivered",
          "reactions": [
            {"userId": "user_045", "emoji": "🤗"},
          ],
        },
      ];

      setState(() {
        _messages.insertAll(0, olderMessages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: Column(
        children: [
          ChatHeaderWidget(
            roomTopic: "Depression Support Group",
            participantCount: _participants.length,
            onBackPressed: () => Navigator.pop(context),
            onParticipantsPressed: _showParticipants,
            onMenuPressed: _showRoomOptions,
          ),
          if (!_isConnected) _buildConnectionStatus(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshMessages,
              color: AppTheme.accentPurple,
              backgroundColor: AppTheme.secondaryDark,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(bottom: 2.h),
                itemCount: _messages.length + (_typingUsers.isNotEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return TypingIndicatorWidget(typingUsers: _typingUsers);
                  }

                  final message = _messages[index];
                  final isCurrentUser = message['senderId'] == _currentUserId;

                  return ChatMessageWidget(
                    message: message,
                    isCurrentUser: isCurrentUser,
                    onReply: () => _replyToMessage(message),
                    onReact: (emoji) =>
                        _reactToMessage(message['id'] as String, emoji),
                    onReport: () {
                      // TODO: Implement report functionality
                    },
                    onBlockUser: () =>
                        _blockUser(message['senderId'] as String),
                  );
                },
              ),
            ),
          ),
          ChatInputWidget(
            onSendMessage: _sendMessage,
            replyingTo: _replyingTo,
            onCancelReply: () => setState(() => _replyingTo = null),
            onEmojiTap: () {
              // TODO: Implement emoji picker
            },
          ),
        ],
      ),
      floatingActionButton: !_autoScroll
          ? FloatingActionButton.small(
              onPressed: _scrollToBottom,
              backgroundColor: AppTheme.accentPurple,
              child: CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                color: AppTheme.textPrimary,
                size: 20,
              ),
            )
          : null,
    );
  }

  Widget _buildConnectionStatus() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      color: AppTheme.warningAmber.withValues(alpha: 0.2),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'wifi_off',
              size: 16,
              color: AppTheme.warningAmber,
            ),
            SizedBox(width: 2.w),
            Text(
              'Reconnecting...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.warningAmber,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
