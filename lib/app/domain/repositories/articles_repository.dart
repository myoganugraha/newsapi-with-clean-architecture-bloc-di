import 'package:dartz/dartz.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/error/failure.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/entities/article_entity.dart';

abstract class ArticlesRepository {
  Future<Either<Failure, List<ArticleEntity>>> getLocalArticles();
  Future<Either<Failure, List<ArticleEntity>>> getRemoteArticles();
}
