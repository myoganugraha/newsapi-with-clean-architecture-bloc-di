import 'package:newsapi_clean_architecture_cubit/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/usecases/usecases.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/entities/article_entity.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/repositories/articles_repository.dart';

class GetRemoteArticlesUsecase
    implements UseCase<List<ArticleEntity>, NoParams> {
  final ArticlesRepository articleRepository;

  GetRemoteArticlesUsecase({required this.articleRepository});

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) async {
    return await articleRepository.getRemoteArticles();
  }
}
