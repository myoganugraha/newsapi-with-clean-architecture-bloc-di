import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/error/failure.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/network/network_info.dart';
import 'package:newsapi_clean_architecture_cubit/app/core/usecases/usecases.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/entities/article_entity.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/usecases/get_local_articles_usecase.dart';
import 'package:newsapi_clean_architecture_cubit/app/domain/usecases/get_remote_articles_usecase.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  // get dependencies
  final NetworkInfo network;
  final GetRemoteArticlesUsecase getRemoteArticles;
  final GetLocalArticleUsecase getLocalArticles;

  ArticlesCubit({
    required this.network,
    required this.getRemoteArticles,
    required this.getLocalArticles,
  }) : super(ArticlesInitial());

  Future<void> getArticles() async {
    emit(ArticlesIsLoading());
    final connectivity = await network.isConnected();
    Either<Failure, List<ArticleEntity>> failureOrArticles;

    if (connectivity) {
      failureOrArticles = await getRemoteArticles.call(NoParams());
    } else {
      failureOrArticles = await getLocalArticles.call(NoParams());
      waitForConnectivityAndCallGetArticles();
      Get.snackbar(
        'Offline mode',
        'There is no internet connection',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    emit(failureOrArticles.fold(
      (l) => ArticlesOnError(failure: l, isOffline: !connectivity),
      (r) => ArticlesIsLoaded(articles: r, isOffline: !connectivity),
    ));
  }

  void waitForConnectivityAndCallGetArticles() {
    StreamSubscription? subscription;
    subscription = network.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        subscription!.cancel();
        getArticles();
      }
    });
  }
}
