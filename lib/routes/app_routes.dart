import 'package:flutter/material.dart';
import '../presentation/main_feed/main_feed.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/user_profile/user_profile.dart';
import '../presentation/confession_detail/confession_detail.dart';
import '../presentation/live_chat_interface/live_chat_interface.dart';
import '../presentation/anonymous_chat_rooms/anonymous_chat_rooms.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String mainFeed = '/main-feed';
  static const String splash = '/splash-screen';
  static const String userProfile = '/user-profile';
  static const String confessionDetail = '/confession-detail';
  static const String liveChatInterface = '/live-chat-interface';
  static const String anonymousChatRooms = '/anonymous-chat-rooms';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    mainFeed: (context) => const MainFeed(),
    splash: (context) => const SplashScreen(),
    userProfile: (context) => const UserProfile(),
    confessionDetail: (context) => const ConfessionDetail(),
    liveChatInterface: (context) => const LiveChatInterface(),
    anonymousChatRooms: (context) => const AnonymousChatRooms(),
    // TODO: Add your other routes here
  };
}
