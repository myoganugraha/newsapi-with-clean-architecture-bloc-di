import 'package:newsapi_clean_architecture_cubit/app/data/datasources/local/articles_local_datasource.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/models/article_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ArticlesLocalDatasourceImpl implements ArticlesLocalDatasource {
  final _kDBFileName = 'sembast_articles.db';
  final _kArticlesStoreName = 'articles_store';

  late Database _database;

  late StoreRef<int, Map<String, dynamic>> _articlesStore;

  @override
  Future<bool> initDb() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _kDBFileName);
      _database = await databaseFactoryIo.openDatabase(dbPath);
      _articlesStore = intMapStoreFactory.store(_kArticlesStoreName);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteDb() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _kDBFileName);
      await databaseFactoryIo.deleteDatabase(dbPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllArticles() async {
    try {
      await _articlesStore.delete(_database);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      final articlesSnapshot = await _articlesStore.find(_database);
      return articlesSnapshot
          .map((snapshot) => ArticleModel.fromJson(snapshot.value))
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> insertArticles(List<ArticleModel> articles) async {
    try {
      await _articlesStore.delete(_database);
      for (final articleModel in articles) {
        await _articlesStore.add(_database, articleModel.toJson());
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
