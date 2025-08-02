import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/active_rooms_section_widget.dart';
import './widgets/create_room_modal_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/room_card_widget.dart';

class AnonymousChatRooms extends StatefulWidget {
  const AnonymousChatRooms({super.key});

  @override
  State<AnonymousChatRooms> createState() => _AnonymousChatRoomsState();
}

class _AnonymousChatRoomsState extends State<AnonymousChatRooms>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;
  List<Map<String, dynamic>> _allRooms = [];
  List<Map<String, dynamic>> _filteredRooms = [];
  List<Map<String, dynamic>> _activeRooms = [];
  bool _isLoading = false;
  bool _isSearching = false;
  String _selectedFilter = 'All';

  final List<String> _filterOptions = [
    'All',
    'Active',
    'Popular',
    'Recent',
    'Bookmarked'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _loadMockData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    setState(() {
      _isLoading = true;
    });

    // Mock data for chat rooms
    _allRooms = [
      {
        "id": 1,
        "roomName": "Heartbreak Support Circle",
        "topic":
            "Share your story and find comfort in knowing you're not alone in your journey of healing.",
        "category": "Love",
        "participantCount": 24,
        "isActive": true,
        "lastMessage":
            "Thank you all for listening. This really helps knowing others understand.",
        "lastActivity": DateTime.now().subtract(const Duration(minutes: 5)),
        "isBookmarked": true,
        "hasUnreadMessages": true,
        "unreadCount": 3,
      },
      {
        "id": 2,
        "roomName": "Campus Life Confessions",
        "topic":
            "Anonymous space to share campus experiences, academic stress, and student life challenges.",
        "category": "Campus Life",
        "participantCount": 42,
        "isActive": true,
        "lastMessage":
            "Anyone else feeling overwhelmed with finals approaching?",
        "lastActivity": DateTime.now().subtract(const Duration(minutes: 12)),
        "isBookmarked": false,
        "hasUnreadMessages": true,
        "unreadCount": 7,
      },
      {
        "id": 3,
        "roomName": "Mental Health Check-in",
        "topic":
            "A safe space for mental health discussions, coping strategies, and peer support.",
        "category": "Depression",
        "participantCount": 18,
        "isActive": true,
        "lastMessage":
            "Remember, seeking help is a sign of strength, not weakness.",
        "lastActivity": DateTime.now().subtract(const Duration(minutes: 8)),
        "isBookmarked": true,
        "hasUnreadMessages": false,
        "unreadCount": 0,
      },
      {
        "id": 4,
        "roomName": "Financial Struggles Anonymous",
        "topic":
            "Discuss money worries, budgeting tips, and financial anxiety in a judgment-free zone.",
        "category": "Money",
        "participantCount": 31,
        "isActive": false,
        "lastMessage": "Has anyone tried the 50/30/20 budgeting rule?",
        "lastActivity": DateTime.now().subtract(const Duration(hours: 2)),
        "isBookmarked": false,
        "hasUnreadMessages": false,
        "unreadCount": 0,
      },
      {
        "id": 5,
        "roomName": "Secret Confessions",
        "topic":
            "Share your deepest secrets in complete anonymity. No judgment, only understanding.",
        "category": "Secrets",
        "participantCount": 67,
        "isActive": true,
        "lastMessage":
            "I've been carrying this secret for years and finally feel ready to share...",
        "lastActivity": DateTime.now().subtract(const Duration(minutes: 3)),
        "isBookmarked": false,
        "hasUnreadMessages": true,
        "unreadCount": 12,
      },
      {
        "id": 6,
        "roomName": "Career Anxiety Support",
        "topic":
            "Navigate career decisions, job search stress, and professional growth challenges together.",
        "category": "Career",
        "participantCount": 29,
        "isActive": false,
        "lastMessage":
            "Just got rejected from another interview. Feeling defeated.",
        "lastActivity": DateTime.now().subtract(const Duration(hours: 4)),
        "isBookmarked": true,
        "hasUnreadMessages": false,
        "unreadCount": 0,
      },
      {
        "id": 7,
        "roomName": "Family Drama Venting",
        "topic":
            "Vent about family issues, toxic relationships, and complicated family dynamics.",
        "category": "Family",
        "participantCount": 15,
        "isActive": false,
        "lastMessage":
            "Sometimes I wonder if it's better to cut toxic family members out completely.",
        "lastActivity": DateTime.now().subtract(const Duration(hours: 6)),
        "isBookmarked": false,
        "hasUnreadMessages": false,
        "unreadCount": 0,
      },
    ];

    // Filter active rooms (currently joined)
    _activeRooms = _allRooms
        .where((room) =>
            (room['hasUnreadMessages'] as bool? ?? false) ||
            (room['isBookmarked'] as bool? ?? false))
        .toList();

    _filteredRooms = List.from(_allRooms);

    setState(() {
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreRooms();
    }
  }

  void _loadMoreRooms() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate loading more rooms
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _filterRooms(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredRooms = List.from(_allRooms);
      } else {
        _filteredRooms = _allRooms.where((room) {
          final roomName = (room['roomName'] as String).toLowerCase();
          final topic = (room['topic'] as String).toLowerCase();
          final category = (room['category'] as String).toLowerCase();
          final searchQuery = query.toLowerCase();

          return roomName.contains(searchQuery) ||
              topic.contains(searchQuery) ||
              category.contains(searchQuery);
        }).toList();
      }
    });
  }

  void _applyFilter(String filter) {
    setState(() {
      _selectedFilter = filter;

      switch (filter) {
        case 'Active':
          _filteredRooms =
              _allRooms.where((room) => room['isActive'] as bool).toList();
          break;
        case 'Popular':
          _filteredRooms = List.from(_allRooms)
            ..sort((a, b) => (b['participantCount'] as int)
                .compareTo(a['participantCount'] as int));
          break;
        case 'Recent':
          _filteredRooms = List.from(_allRooms)
            ..sort((a, b) => (b['lastActivity'] as DateTime)
                .compareTo(a['lastActivity'] as DateTime));
          break;
        case 'Bookmarked':
          _filteredRooms =
              _allRooms.where((room) => room['isBookmarked'] as bool).toList();
          break;
        default:
          _filteredRooms = List.from(_allRooms);
      }
    });
  }

  void _joinRoom(Map<String, dynamic> room) {
    Navigator.pushNamed(
      context,
      '/live-chat-interface',
      arguments: room,
    );
  }

  void _toggleBookmark(Map<String, dynamic> room) {
    setState(() {
      final index = _allRooms.indexWhere((r) => r['id'] == room['id']);
      if (index != -1) {
        _allRooms[index]['isBookmarked'] = !(room['isBookmarked'] as bool);
        _updateActiveRooms();
      }
    });
  }

  void _reportRoom(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Room'),
        content: const Text(
            'Are you sure you want to report this room for inappropriate content?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Room reported successfully')),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _blockRoom(Map<String, dynamic> room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block Room'),
        content: const Text(
            'Are you sure you want to block this room? You won\'t see it in your feed anymore.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _allRooms.removeWhere((r) => r['id'] == room['id']);
                _filteredRooms.removeWhere((r) => r['id'] == room['id']);
                _updateActiveRooms();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Room blocked successfully')),
              );
            },
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  void _updateActiveRooms() {
    _activeRooms = _allRooms
        .where((room) =>
            (room['hasUnreadMessages'] as bool? ?? false) ||
            (room['isBookmarked'] as bool? ?? false))
        .toList();
  }

  void _createRoom(Map<String, dynamic> roomData) {
    setState(() {
      final newRoom = Map<String, dynamic>.from(roomData);
      newRoom['id'] = _allRooms.length + 1;
      _allRooms.insert(0, newRoom);
      _filteredRooms = List.from(_allRooms);
      _updateActiveRooms();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Room created successfully!')),
    );
  }

  void _showCreateRoomModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateRoomModalWidget(
        onCreateRoom: _createRoom,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: CustomAppBar.chatRooms(context),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFeedTab(),
                _buildChatTab(),
                _buildProfileTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar.chatRooms(
        onTap: (item) {
          // Handle navigation
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateRoomModal,
        child: CustomIconWidget(
          iconName: 'add',
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterRooms,
                  decoration: InputDecoration(
                    hintText: 'Search rooms, topics, categories...',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'search',
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        size: 20,
                      ),
                    ),
                    suffixIcon: _isSearching
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _filterRooms('');
                            },
                            icon: CustomIconWidget(
                              iconName: 'clear',
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.6),
                              size: 20,
                            ),
                          )
                        : null,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              PopupMenuButton<String>(
                onSelected: _applyFilter,
                icon: CustomIconWidget(
                  iconName: 'filter_list',
                  color: _selectedFilter != 'All'
                      ? AppTheme.accentPurple
                      : colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 24,
                ),
                itemBuilder: (context) => _filterOptions.map((filter) {
                  return PopupMenuItem<String>(
                    value: filter,
                    child: Row(
                      children: [
                        if (_selectedFilter == filter)
                          CustomIconWidget(
                            iconName: 'check',
                            color: AppTheme.accentPurple,
                            size: 16,
                          ),
                        if (_selectedFilter == filter) SizedBox(width: 2.w),
                        Text(
                          filter,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: _selectedFilter == filter
                                ? AppTheme.accentPurple
                                : colorScheme.onSurface,
                            fontWeight: _selectedFilter == filter
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          if (_selectedFilter != 'All') ...[
            SizedBox(height: 1.h),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppTheme.accentPurple.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Filter: $_selectedFilter',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.accentPurple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      GestureDetector(
                        onTap: () => _applyFilter('All'),
                        child: CustomIconWidget(
                          iconName: 'close',
                          color: AppTheme.accentPurple,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${_filteredRooms.length} rooms',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return const Center(
      child: Text('Feed Tab - Navigate to /main-feed'),
    );
  }

  Widget _buildChatTab() {
    if (_isLoading && _filteredRooms.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_filteredRooms.isEmpty && !_isLoading) {
      return EmptyStateWidget(
        onCreateRoom: _showCreateRoomModal,
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _loadMockData();
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (_activeRooms.isNotEmpty)
            SliverToBoxAdapter(
              child: ActiveRoomsSectionWidget(
                activeRooms: _activeRooms,
                onRoomTap: _joinRoom,
              ),
            ),
          if (_activeRooms.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Divider(
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.2),
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Text(
                _isSearching ? 'Search Results' : 'All Rooms',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= _filteredRooms.length) {
                  return _isLoading
                      ? Container(
                          padding: EdgeInsets.all(4.w),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink();
                }

                final room = _filteredRooms[index];
                return RoomCardWidget(
                  roomData: room,
                  onTap: () => _joinRoom(room),
                  onBookmark: () => _toggleBookmark(room),
                  onReport: () => _reportRoom(room),
                  onBlock: () => _blockRoom(room),
                );
              },
              childCount: _filteredRooms.length + (_isLoading ? 1 : 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return const Center(
      child: Text('Profile Tab - Navigate to /user-profile'),
    );
  }
}
