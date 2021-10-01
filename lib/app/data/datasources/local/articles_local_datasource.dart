import 'package:newsapi_clean_architecture_cubit/app/data/models/article_model.dart';

abstract class ArticlesLocalDatasource {
  Future<bool> initDb();
  Future<bool> deleteDb();
  Future<bool> insertArticles(List<ArticleModel> articles);
  Future<bool> deleteAllArticles();
  Future<List<ArticleModel>> getArticles();
}