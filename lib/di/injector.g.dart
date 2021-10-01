// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureCore() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => Connectivity())
      ..registerSingleton<NetworkInfo>(
          (c) => NetworkInfoImpl(connectivity: c<Connectivity>()));
  }

  @override
  void _configureArticlesFeatureModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory<ArticlesLocalDatasource>(
          (c) => ArticlesLocalDatasourceImpl())
      ..registerFactory(
          (c) => ArticlesRemoteDatasource(apiClient: c<ApiClient>()))
      ..registerFactory((c) =>
          GetLocalArticleUsecase(articleRepository: c<ArticlesRepository>()))
      ..registerFactory((c) =>
          GetRemoteArticlesUsecase(articleRepository: c<ArticlesRepository>()))
      ..registerFactory<ArticlesRepository>((c) => ArticlesRepositoryImpl(
          localDatasource: c<ArticlesLocalDatasource>(),
          remoteDatasource: c<ArticlesRemoteDatasource>()))
      ..registerFactory((c) => ArticlesCubit(
          network: c<NetworkInfo>(),
          getRemoteArticles: c<GetRemoteArticlesUsecase>(),
          getLocalArticles: c<GetLocalArticleUsecase>()));
  }
}
