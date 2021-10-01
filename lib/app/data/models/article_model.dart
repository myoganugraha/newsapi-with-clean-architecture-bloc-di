import 'package:json_annotation/json_annotation.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/entities/article_entity.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required String? title,
    required String? content,
    required DateTime? publishedAt,
    required String? url,
    required String? urlToImage,
    required String? author,
  }) : super(
            author: author,
            title: title,
            content: content,
            publishedAt: publishedAt,
            url: url,
            urlToImage: urlToImage);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
