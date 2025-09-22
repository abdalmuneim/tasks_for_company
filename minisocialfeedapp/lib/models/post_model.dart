class PostModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String authorId;
  final String authorName;
  final List<String> likedBy;
  final DateTime createdAt;
  final List<String> hashtags;
  final int commentCount;
  final int shareCount;

  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.authorId,
    required this.authorName,
    required this.likedBy,
    required this.createdAt,
    this.hashtags = const [],
    this.commentCount = 0,
    this.shareCount = 0,
  });

  int get likeCount => likedBy.length;

  bool isLikedBy(String userId) => likedBy.contains(userId);

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      likedBy: List<String>.from(map['likedBy'] ?? []),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      hashtags: List<String>.from(map['hashtags'] ?? []),
      commentCount: map['commentCount'] ?? 0,
      shareCount: map['shareCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'authorName': authorName,
      'likedBy': likedBy,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'hashtags': hashtags,
      'commentCount': commentCount,
      'shareCount': shareCount,
    };
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? authorId,
    String? authorName,
    List<String>? likedBy,
    DateTime? createdAt,
    List<String>? hashtags,
    int? commentCount,
    int? shareCount,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      likedBy: likedBy ?? this.likedBy,
      createdAt: createdAt ?? this.createdAt,
      hashtags: hashtags ?? this.hashtags,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
    );
  }
}
