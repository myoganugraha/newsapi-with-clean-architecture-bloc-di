import 'package:dio/dio.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/models/article_model.dart';

class ApiClient {
  Dio dio;
  String apiKey;
  final String baseUrl = 'https://newsapi.org/v2/';

  ApiClient({required this.dio, required this.apiKey});

  Future<List<ArticleModel>> getTopHeadlines() async {
    var _result = await dio
        .get(baseUrl + '/top-headlines?country=id&pageSize=100&apiKey=$apiKey');

    List articles = _result.data['articles'];
    return articles.map((article) => ArticleModel.fromJson(article)).toList();
  }
}
