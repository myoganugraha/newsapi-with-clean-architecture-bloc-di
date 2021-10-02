part of 'articles_cubit.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlesIsLoading extends ArticlesState {}

class ArticlesIsLoaded extends ArticlesState {
  final List<ArticleEntity> articles;
  final bool isOffline;

  const ArticlesIsLoaded({required this.articles, required this.isOffline});
}

class ArticlesOnError extends ArticlesState {
  final Failure failure;
  final bool isOffline;

  const ArticlesOnError({required this.failure, required this.isOffline});
}
