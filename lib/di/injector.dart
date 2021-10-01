import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kiwi/kiwi.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/network/network_info.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/client/api_client.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/datasources/local/articles_local_datasource.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/datasources/local/articles_local_datasource_impl.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/datasources/remote/articles_remote_datasource.dart';
import 'package:newsapi_clean_architecture_cubit/app/data/repositories/articles_repository_impl.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/repositories/articles_repository.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/usecases/get_local_articles_usecase.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/usecases/get_remote_articles_usecase.dart';
import 'package:newsapi_clean_architecture_cubit/app/presentation/home/cubit/articles_cubit.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    _$Injector().configure();
  }

  static final resolve = container.resolve;

  void configure() {
    _configureCore();
    _configureArticlesFeatureModule();
  }

  // Core module
  @Register.singleton(Connectivity)
  @Register.singleton(NetworkInfo, from: NetworkInfoImpl)
  void _configureCore();

  // Articles Feature module
  void _configureArticlesFeatureModule() {
    _configureArticlesFeatureModuleInstances();
    _configureArticlesFeatureModuleFactories();
  }

  void _configureArticlesFeatureModuleInstances() {
    container.registerInstance(
      ApiClient(
        dio: Dio()
          ..interceptors.add(
            LogInterceptor(
              responseBody: true,
              request: true,
            ),
          ),
        apiKey: dotenv.get('API_KEY'),
      ),
    );
  }

  @Register.factory(ArticlesLocalDatasource, from: ArticlesLocalDatasourceImpl)
  @Register.factory(ArticlesRemoteDatasource)
  @Register.factory(GetLocalArticleUsecase)
  @Register.factory(GetRemoteArticlesUsecase)
  @Register.factory(ArticlesRepository, from: ArticlesRepositoryImpl)
  @Register.factory(ArticlesCubit)
  void _configureArticlesFeatureModuleFactories();
}
