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

  const ArticlesIsLoaded({required this.articles});
}

class ArticlesOnError extends ArticlesState {
  final Failure failure;

  const ArticlesOnError({required this.failure});
}
