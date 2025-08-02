import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/comment_input_widget.dart';
import './widgets/comment_item_widget.dart';
import './widgets/confession_card_widget.dart';
import './widgets/empty_comments_widget.dart';

class ConfessionDetail extends StatefulWidget {
  const ConfessionDetail({super.key});

  @override
  State<ConfessionDetail> createState() => _ConfessionDetailState();
}

class _ConfessionDetailState extends State<ConfessionDetail> {
  final ScrollController _scrollController = ScrollController();
  String? _replyToUser;
  bool _isLoading = false;
  bool _isRefreshing = false;

  // Mock confession data
  final Map<String, dynamic> _confessionData = {
    "id": 1,
    "userId": "User #1247",
    "category": "Depression",
    "content":
        """I've been struggling with anxiety and depression for months now. Every day feels like a battle, and I'm exhausted from pretending everything is okay. I can't tell my family because they wouldn't understand, and my friends seem too busy with their own lives.

Sometimes I wonder if anyone would even notice if I just disappeared. The worst part is feeling so alone even when I'm surrounded by people. I know I should probably talk to someone professional, but I'm scared of being judged or labeled.

Has anyone else felt this way? How did you get through it? I just need to know that it gets better somehow.""",
    "timestamp": DateTime.now().subtract(const Duration(hours: 3)),
    "reactions": {
      "like": 24,
      "hug": 67,
      "support": 45,
      "same": 89,
    },
    "commentCount": 23,
  };

  // Mock comments data
  List<Map<String, dynamic>> _commentsData = [
    {
      "id": 1,
      "userId": "User #892",
      "content":
          "I've been exactly where you are. It took time, but therapy really helped me understand that these feelings are temporary. You're not alone in this fight. 💙",
      "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
      "reactions": {"like": 12, "hug": 8, "support": 15},
      "parentId": null,
    },
    {
      "id": 2,
      "userId": "User #1456",
      "content":
          "Thank you for sharing this. It takes courage to be vulnerable.",
      "timestamp":
          DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      "reactions": {"like": 5, "hug": 3, "support": 7},
      "parentId": 1,
    },
    {
      "id": 3,
      "userId": "User #2341",
      "content":
          "Please consider reaching out to a mental health professional. There are also free hotlines available 24/7. Your life has value and meaning, even when it doesn't feel like it.",
      "timestamp":
          DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      "reactions": {"like": 18, "hug": 12, "support": 22},
      "parentId": null,
    },
    {
      "id": 4,
      "userId": "User #567",
      "content":
          "I started with small steps - just getting out of bed, taking a shower, eating one meal. Celebrate the tiny victories. They add up.",
      "timestamp": DateTime.now().subtract(const Duration(hours: 1)),
      "reactions": {"like": 9, "hug": 6, "support": 11},
      "parentId": 3,
    },
    {
      "id": 5,
      "userId": "User #1789",
      "content":
          "The fact that you're reaching out here shows incredible strength. That's the first step towards healing. Keep going, one day at a time.",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 45)),
      "reactions": {"like": 7, "hug": 4, "support": 9},
      "parentId": null,
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar.confessionDetail(context),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              color: colorScheme.primary,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: ConfessionCardWidget(
                      confession: _confessionData,
                      onReaction: _handleConfessionReaction,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'chat_bubble',
                            color: colorScheme.primary,
                            size: 5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Comments (${_commentsData.length})',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _isLoading
                      ? SliverToBoxAdapter(
                          child: _buildLoadingSkeleton(),
                        )
                      : _commentsData.isEmpty
                          ? const SliverToBoxAdapter(
                              child: EmptyCommentsWidget(),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final comment = _commentsData[index];
                                  final indentLevel = _getIndentLevel(comment);

                                  return CommentItemWidget(
                                    comment: comment,
                                    indentLevel: indentLevel,
                                    onReply: () => _handleReply(
                                        comment['userId'] as String),
                                    onReport: () => _handleReportComment(
                                        comment['id'] as int),
                                    onReaction: () => _handleCommentReaction(
                                        comment['id'] as int),
                                  );
                                },
                                childCount: _commentsData.length,
                              ),
                            ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20.h), // Space for input widget
                  ),
                ],
              ),
            ),
          ),
          CommentInputWidget(
            replyToUser: _replyToUser,
            onCancelReply: () => setState(() => _replyToUser = null),
            onSubmitComment: _handleSubmitComment,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    width: 30.w,
                    height: 2.h,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Container(
                width: double.infinity,
                height: 1.5.h,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                width: 70.w,
                height: 1.5.h,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  int _getIndentLevel(Map<String, dynamic> comment) {
    final parentId = comment['parentId'] as int?;
    if (parentId == null) return 0;

    // Find parent comment and calculate indent level
    final parentComment = _commentsData.firstWhere(
      (c) => c['id'] == parentId,
      orElse: () => <String, dynamic>{},
    );

    if (parentComment.isEmpty) return 0;
    return _getIndentLevel(parentComment) + 1;
  }

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Add a new mock comment
    final newComment = {
      "id": _commentsData.length + 1,
      "userId": "User #${DateTime.now().millisecondsSinceEpoch % 10000}",
      "content":
          "Just saw this post. Sending you virtual hugs and positive energy. You matter more than you know! 🤗",
      "timestamp": DateTime.now(),
      "reactions": {"like": 0, "hug": 0, "support": 0},
      "parentId": null,
    };

    setState(() {
      _commentsData.insert(0, newComment);
      _confessionData['commentCount'] =
          (_confessionData['commentCount'] as int) + 1;
      _isRefreshing = false;
    });
  }

  void _handleConfessionReaction() {
    HapticFeedback.lightImpact();
    // TODO: Implement confession reaction logic
  }

  void _handleCommentReaction(int commentId) {
    HapticFeedback.lightImpact();
    // TODO: Implement comment reaction logic
  }

  void _handleReply(String userId) {
    setState(() => _replyToUser = userId);
  }

  void _handleReportComment(int commentId) {
    _showReportDialog(commentId);
  }

  void _handleSubmitComment(String content) {
    HapticFeedback.mediumImpact();

    final newComment = {
      "id": _commentsData.length + 1,
      "userId": "User #${DateTime.now().millisecondsSinceEpoch % 10000}",
      "content": content,
      "timestamp": DateTime.now(),
      "reactions": {"like": 0, "hug": 0, "support": 0},
      "parentId": _replyToUser != null
          ? _commentsData.firstWhere(
              (c) => c['userId'] == _replyToUser,
              orElse: () => <String, dynamic>{'id': null},
            )['id'] as int?
          : null,
    };

    setState(() {
      _commentsData.add(newComment);
      _confessionData['commentCount'] =
          (_confessionData['commentCount'] as int) + 1;
      _replyToUser = null;
    });

    // Scroll to bottom to show new comment
    Future.delayed(const Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void _showReportDialog(int commentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Comment'),
        content: const Text(
            'Are you sure you want to report this comment for inappropriate content?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showReportConfirmation();
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _showReportConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
            'Comment reported. Thank you for helping keep our community safe.'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
