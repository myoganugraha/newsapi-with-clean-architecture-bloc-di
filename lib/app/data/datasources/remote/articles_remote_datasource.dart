import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/error/failure.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/client/api_client.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/models/article_model.dart';

const errorMessage = 'Something went wrong';

class ArticlesRemoteDatasource {
  final ApiClient apiClient;
  ArticlesRemoteDatasource({required this.apiClient});

  Future<Either<Failure, List<ArticleModel>>> getArticles() async {
    try {
      final articles = await apiClient.getTopHeadlines();
      return Right(articles);
    } on DioError catch (error) {
      return Left(Failure(message: error.response!.statusMessage!));
    } on Exception catch (_) {
      return const Left(Failure(message: errorMessage));
    }
  }
}
