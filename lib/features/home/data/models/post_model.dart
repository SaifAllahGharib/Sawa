import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String id;
  final String? content;
  final String? image;
  final String author;
  final DateTime createdAt;

  const PostModel({
    required this.id,
    this.content,
    this.image,
    required this.author,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      content: json['content'] as String?,
      image: json['image'] as String?,
      author: json['author'] as String,
      createdAt: _parseDateTime(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'image': image,
      'author': author,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.parse(value);
    throw ArgumentError('Invalid date format for createdAt');
  }

  PostModel copyWith({
    String? id,
    String? content,
    String? image,
    String? author,
    DateTime? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      content: content ?? this.content,
      image: image ?? this.image,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, content, image, author, createdAt];

  @override
  String toString() {
    return 'PostModel(id: $id, content: $content, image: $image, author: $author, createdAt: $createdAt)';
  }
}
