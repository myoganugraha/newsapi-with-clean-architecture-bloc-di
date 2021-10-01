import 'package:newsapi_clean_architecture_cubit/app/data/datasources/local/articles_local_datasource.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/datasources/remote/articles_remote_datasource.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/entities/article_entity.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/repositories/articles_repository.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final ArticlesLocalDatasource localDatasource;
  final ArticlesRemoteDatasource remoteDatasource;

  ArticlesRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<ArticleEntity>>> getLocalArticles() async {
    final articles = await localDatasource.getArticles();
    if (articles.isEmpty) {
      return const Left(Failure(message: 'Failed to fetch local data'));
    }
    return Right(articles);
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getRemoteArticles() async {
    try {
      final response = await remoteDatasource.getArticles();
      return response.fold((failure) => Left(failure), (articles) async {
        if (articles.isNotEmpty) {
          await localDatasource.insertArticles(articles);
          return Right(articles);
        }
        return const Left(Failure(message: 'Cannot retrieve data'));
      });
    } on Exception catch (_) {
      return const Left(Failure(message: 'Something went wrong'));
    }
  }
}
