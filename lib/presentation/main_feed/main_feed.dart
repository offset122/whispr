import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/confession_card_widget.dart';
import './widgets/confession_composer_modal_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/floating_compose_button_widget.dart';
import './widgets/topic_filter_chip_widget.dart';

class MainFeed extends StatefulWidget {
  const MainFeed({super.key});

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  String _selectedTopic = 'All';
  bool _isLoading = false;
  bool _isRefreshing = false;
  List<Map<String, dynamic>> _confessions = [];
  List<Map<String, dynamic>> _filteredConfessions = [];

  final List<String> _topics = [
    'All',
    'Love',
    'Campus Life',
    'Depression',
    'Money',
    'Secrets'
  ];
  final Map<String, int> _topicCounts = {
    'All': 0,
    'Love': 0,
    'Campus Life': 0,
    'Depression': 0,
    'Money': 0,
    'Secrets': 0,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadMockData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    final List<Map<String, dynamic>> mockConfessions = [
      {
        "id": 1,
        "userId": "User #1234",
        "content":
            "I've been struggling with anxiety about my upcoming exams. Sometimes I feel like I'm not smart enough for university, but I'm too scared to tell anyone because they expect so much from me.",
        "topic": "Campus Life",
        "timestamp": DateTime.now().subtract(const Duration(hours: 2)),
        "reactions": {"like": 12, "hug": 8, "support": 15, "sameHere": 6},
        "commentCount": 23,
      },
      {
        "id": 2,
        "userId": "User #5678",
        "content":
            "I think I'm falling for my best friend but I'm terrified of ruining our friendship. We've known each other for years and I don't want to lose what we have.",
        "topic": "Love",
        "timestamp": DateTime.now().subtract(const Duration(hours: 5)),
        "reactions": {"like": 8, "hug": 12, "support": 9, "sameHere": 18},
        "commentCount": 31,
      },
      {
        "id": 3,
        "userId": "User #9012",
        "content":
            "My family keeps asking me about my future plans but honestly, I have no idea what I want to do with my life. Everyone else seems so sure about their path.",
        "topic": "Campus Life",
        "timestamp": DateTime.now().subtract(const Duration(hours: 8)),
        "reactions": {"like": 15, "hug": 7, "support": 22, "sameHere": 28},
        "commentCount": 19,
      },
      {
        "id": 4,
        "userId": "User #3456",
        "content":
            "I've been feeling really down lately and I don't know why. Everything feels overwhelming and I can't seem to enjoy things I used to love.",
        "topic": "Depression",
        "timestamp": DateTime.now().subtract(const Duration(hours: 12)),
        "reactions": {"like": 5, "hug": 25, "support": 18, "sameHere": 14},
        "commentCount": 42,
      },
      {
        "id": 5,
        "userId": "User #7890",
        "content":
            "I'm working part-time while studying and I'm constantly worried about money. I see my friends going out and buying things while I'm counting every shilling.",
        "topic": "Money",
        "timestamp": DateTime.now().subtract(const Duration(hours: 18)),
        "reactions": {"like": 9, "hug": 11, "support": 16, "sameHere": 21},
        "commentCount": 27,
      },
      {
        "id": 6,
        "userId": "User #2468",
        "content":
            "I've never told anyone this, but I sometimes feel like I'm living a double life. The person I am at home is completely different from who I am with friends.",
        "topic": "Secrets",
        "timestamp": DateTime.now().subtract(const Duration(days: 1)),
        "reactions": {"like": 7, "hug": 9, "support": 13, "sameHere": 24},
        "commentCount": 16,
      },
    ];

    setState(() {
      _confessions = mockConfessions;
      _updateTopicCounts();
      _filterConfessions();
    });
  }

  void _updateTopicCounts() {
    _topicCounts.clear();
    _topicCounts['All'] = _confessions.length;

    for (final confession in _confessions) {
      final topic = confession['topic'] as String;
      _topicCounts[topic] = (_topicCounts[topic] ?? 0) + 1;
    }
  }

  void _filterConfessions() {
    if (_selectedTopic == 'All') {
      _filteredConfessions = List.from(_confessions);
    } else {
      _filteredConfessions = _confessions
          .where((confession) => confession['topic'] == _selectedTopic)
          .toList();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreConfessions();
    }
  }

  void _loadMoreConfessions() {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    // Simulate loading more confessions
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  Future<void> _refreshConfessions() async {
    setState(() => _isRefreshing = true);

    // Simulate refresh
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isRefreshing = false);
    }
  }

  void _onTopicSelected(String topic) {
    setState(() {
      _selectedTopic = topic;
      _filterConfessions();
    });
  }

  void _onReaction(String confessionId, String reactionType) {
    setState(() {
      final confessionIndex =
          _confessions.indexWhere((c) => c['id'].toString() == confessionId);
      if (confessionIndex != -1) {
        final reactions =
            _confessions[confessionIndex]['reactions'] as Map<String, dynamic>;
        reactions[reactionType] = (reactions[reactionType] as int) + 1;
        _filterConfessions();
      }
    });
  }

  void _showConfessionComposer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ConfessionComposerModalWidget(
        onSubmit: _onConfessionSubmitted,
      ),
    );
  }

  void _onConfessionSubmitted(Map<String, dynamic> confession) {
    setState(() {
      _confessions.insert(0, confession);
      _updateTopicCounts();
      _filterConfessions();
    });
  }

  void _onConfessionTap(Map<String, dynamic> confession) {
    Navigator.pushNamed(context, '/confession-detail', arguments: confession);
  }

  void _onConfessionLongPress(Map<String, dynamic> confession) {
    _showConfessionOptions(confession);
  }

  void _showConfessionOptions(Map<String, dynamic> confession) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
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
                color: colorScheme.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'bookmark_outline',
                size: 24,
                color: colorScheme.onSurface,
              ),
              title: const Text('Bookmark'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement bookmark functionality
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'block',
                size: 24,
                color: colorScheme.onSurface,
              ),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement block functionality
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'report',
                size: 24,
                color: AppTheme.errorRose,
              ),
              title: Text(
                'Report',
                style: TextStyle(color: AppTheme.errorRose),
              ),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar.mainFeed(context),
      body: Stack(
        children: [
          Column(
            children: [
              _buildTabBar(context),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildFeedTab(context),
                    _buildChatTab(context),
                    _buildProfileTab(context),
                  ],
                ),
              ),
            ],
          ),
          FloatingComposeButtonWidget(
            onPressed: _showConfessionComposer,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar.mainFeed(
        onTap: (item) {
          // Handle bottom navigation
        },
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
        indicatorColor: colorScheme.primary,
        indicatorWeight: 3,
        labelStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: 'Feed'),
          Tab(text: 'Chat'),
          Tab(text: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildFeedTab(BuildContext context) {
    return Column(
      children: [
        _buildTopicFilters(context),
        Expanded(
          child: _filteredConfessions.isEmpty
              ? EmptyStateWidget(onCreateConfession: _showConfessionComposer)
              : RefreshIndicator(
                  onRefresh: _refreshConfessions,
                  color: Theme.of(context).colorScheme.primary,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        _filteredConfessions.length + (_isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _filteredConfessions.length) {
                        return _buildLoadingIndicator(context);
                      }

                      final confession = _filteredConfessions[index];
                      return ConfessionCardWidget(
                        confession: confession,
                        onTap: () => _onConfessionTap(confession),
                        onLongPress: () => _onConfessionLongPress(confession),
                        onReaction: (reactionType) => _onReaction(
                          confession['id'].toString(),
                          reactionType,
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildTopicFilters(BuildContext context) {
    return Container(
      height: 7.h,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: _topics.length,
        itemBuilder: (context, index) {
          final topic = _topics[index];
          return TopicFilterChipWidget(
            topic: topic,
            isSelected: _selectedTopic == topic,
            count: _topicCounts[topic] ?? 0,
            onTap: () => _onTopicSelected(topic),
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildChatTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'chat_bubble_outline',
            size: 15.w,
            color: colorScheme.primary.withValues(alpha: 0.6),
          ),
          SizedBox(height: 2.h),
          Text(
            'Chat Rooms',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Join anonymous chat rooms for real-time support',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/anonymous-chat-rooms'),
            child: const Text('Explore Rooms'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'person_outline',
            size: 15.w,
            color: colorScheme.primary.withValues(alpha: 0.6),
          ),
          SizedBox(height: 2.h),
          Text(
            'Your Profile',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Manage your anonymous profile and settings',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/user-profile'),
            child: const Text('View Profile'),
          ),
        ],
      ),
    );
  }
}
