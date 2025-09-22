import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/firestore_service.dart';

class CreatePostProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;
  String? _errorMessage;
  List<String> _suggestedHashtags = [];
  List<String> _allHashtags = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get suggestedHashtags => _suggestedHashtags;
  List<String> get allHashtags => _allHashtags;

  CreatePostProvider() {
    _loadHashtagsFromDummyPosts();
  }

  Future<bool> createPost({
    required String title,
    required String description,
    required String imageUrl,
    required String authorId,
    required String authorName,
    required List<String> hashtags,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firestoreService.createPost(
        title: title,
        description: description,
        imageUrl: imageUrl,
        authorId: authorId,
        authorName: authorName,
        hashtags: hashtags,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Failed to create post: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load hashtags from dummy_posts.json for suggestions
  Future<void> _loadHashtagsFromDummyPosts() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/dummy_posts.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> postsJson = jsonData['posts'] ?? [];

      Set<String> hashtagSet = {};
      for (var post in postsJson) {
        final List<dynamic> hashtags = post['hashtags'] ?? [];
        for (var hashtag in hashtags) {
          hashtagSet.add(hashtag.toString());
        }
      }

      _allHashtags = hashtagSet.toList()..sort();
      _suggestedHashtags = _allHashtags
          .take(10)
          .toList(); // Top 10 for suggestions
      notifyListeners();
    } catch (e) {
      print('Error loading hashtags: $e');
    }
  }

  // Extract hashtags from text (e.g., from title or description)
  List<String> extractHashtagsFromText(String text) {
    final RegExp hashtagRegex = RegExp(r'#\w+');
    final matches = hashtagRegex.allMatches(text);
    return matches.map((match) => match.group(0)!).toList();
  }

  // Get suggested hashtags based on keywords in title/description
  List<String> getSuggestedHashtags(String title, String description) {
    final String combinedText = '$title $description'.toLowerCase();
    List<String> suggestions = [];

    // Keyword-based suggestions
    final Map<String, List<String>> keywordToHashtags = {
      'coffee': ['#coffee', '#morningcoffee', '#caffeine', '#coffeelover'],
      'hike': ['#hiking', '#nature', '#outdoor', '#adventure'],
      'hiking': ['#hiking', '#nature', '#outdoor', '#adventure'],
      'nature': ['#nature', '#outdoor', '#beautiful', '#adventure'],
      'sunset': ['#sunset', '#beautiful', '#eveningvibes', '#cityscape'],
      'city': ['#city', '#urban', '#cityview', '#cityscape'],
      'beach': ['#beach', '#summer', '#sun', '#waves', '#summervibes'],
      'night': ['#citylights', '#nightlife', '#nightphotography'],
      'morning': ['#morningvibes', '#morningcoffee'],
      'evening': ['#eveningvibes', '#sunset'],
      'summer': ['#summer', '#summervibes', '#sun', '#beach'],
    };

    for (var entry in keywordToHashtags.entries) {
      if (combinedText.contains(entry.key)) {
        suggestions.addAll(entry.value);
      }
    }

    // Remove duplicates and limit to 8 suggestions
    return suggestions.toSet().take(8).toList();
  }

  // Get popular hashtags (most commonly used)
  List<String> getPopularHashtags() {
    return [
      '#beautiful',
      '#nature',
      '#summer',
      '#city',
      '#coffee',
      '#sunset',
      '#adventure',
      '#outdoor',
      '#urban',
      '#vibes',
    ];
  }

  // Validate hashtag format
  bool isValidHashtag(String hashtag) {
    return hashtag.startsWith('#') &&
        hashtag.length > 1 &&
        RegExp(r'^#[a-zA-Z0-9_]+$').hasMatch(hashtag);
  }

  // Add hashtag with validation
  List<String> addHashtag(List<String> currentHashtags, String newHashtag) {
    final formattedHashtag = newHashtag.startsWith('#')
        ? newHashtag
        : '#$newHashtag';

    if (isValidHashtag(formattedHashtag) &&
        !currentHashtags.contains(formattedHashtag)) {
      return [...currentHashtags, formattedHashtag];
    }

    return currentHashtags;
  }

  // Remove hashtag
  List<String> removeHashtag(List<String> currentHashtags, String hashtag) {
    return currentHashtags.where((h) => h != hashtag).toList();
  }
}
