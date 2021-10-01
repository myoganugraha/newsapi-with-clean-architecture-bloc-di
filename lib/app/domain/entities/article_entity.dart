import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? author;
  final String? title;
  final String? content;
  final DateTime? publishedAt;
  final String? url;
  final String? urlToImage;

  const ArticleEntity({
    required this.author,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.url,
    required this.urlToImage,
  });

  @override
  List<Object?> get props => [title, content, publishedAt, url, urlToImage];
}
