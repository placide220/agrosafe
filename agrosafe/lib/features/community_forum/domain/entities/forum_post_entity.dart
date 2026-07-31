import 'package:equatable/equatable.dart';

class ForumPostEntity extends Equatable {
  final String id;
  final String authorName;
  final String district;
  final String
  category; // 'Women Farmers Circle', 'General Advice', 'Pest Warning'
  final String title;
  final String content;
  final int likesCount;
  final DateTime postedAt;

  const ForumPostEntity({
    required this.id,
    required this.authorName,
    required this.district,
    required this.category,
    required this.title,
    required this.content,
    required this.likesCount,
    required this.postedAt,
  });

  @override
  List<Object?> get props => [
    id,
    authorName,
    district,
    category,
    title,
    content,
    likesCount,
    postedAt,
  ];
}
