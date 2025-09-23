import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/post_model.dart';

class ProfileProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;
  String? _errorMessage;
  List<PostModel> _userPosts = [];
  int _postsCount = 0;
  int _followersCount = 0;
  int _followingCount = 0;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<PostModel> get userPosts => [..._userPosts];
  int get postsCount => _postsCount;
  int get followersCount => _followersCount;
  int get followingCount => _followingCount;

  // Fetch user profile statistics
  Future<void> fetchUserStats(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch user's posts
      final postsStream = _firestoreService.getUserPosts(userId);
      await for (final posts in postsStream.take(1)) {
        _userPosts = posts;
        _postsCount = posts.length;
        break;
      }

      // TODO: Implement followers/following count from Firestore
      // For now, these remain as placeholders
      _followersCount = 0;
      _followingCount = 0;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load profile stats: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear data when user signs out
  void clearData() {
    _userPosts.clear();
    _postsCount = 0;
    _followersCount = 0;
    _followingCount = 0;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  // Refresh profile data
  Future<void> refreshStats(String userId) async {
    await fetchUserStats(userId);
  }
}
