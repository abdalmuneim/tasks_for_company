import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/suggested_user_model.dart';
import '../utils/constants.dart';

class ApiService {
  static const String baseUrl = kDummyJsonBaseUrl;

  // Fetch suggested users from DummyJSON
  Future<List<SuggestedUserModel>> fetchSuggestedUsers({int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users?limit=$limit'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> usersJson = data['users'] ?? [];
        
        return usersJson
            .map((userJson) => SuggestedUserModel.fromJson(userJson))
            .toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Fetch a specific user by ID
  Future<SuggestedUserModel?> fetchUserById(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return SuggestedUserModel.fromJson(userData);
      } else if (response.statusCode == 404) {
        return null; // User not found
      } else {
        throw Exception('Failed to load user: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Search users by name
  Future<List<SuggestedUserModel>> searchUsers(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> usersJson = data['users'] ?? [];
        
        return usersJson
            .map((userJson) => SuggestedUserModel.fromJson(userJson))
            .toList();
      } else {
        throw Exception('Failed to search users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get random users for suggestions
  Future<List<SuggestedUserModel>> getRandomUsers({int count = 5}) async {
    try {
      // Fetch more users and then randomly select from them
      final allUsers = await fetchSuggestedUsers(limit: 30);
      
      if (allUsers.length <= count) {
        return allUsers;
      }

      // Shuffle and take the requested count
      allUsers.shuffle();
      return allUsers.take(count).toList();
    } catch (e) {
      throw Exception('Failed to get random users: $e');
    }
  }
}
