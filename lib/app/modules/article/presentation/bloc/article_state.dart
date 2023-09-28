part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  final List<ArticleDataEntity>? articleList;
  final String? error;

  const ArticleState({this.articleList, this.error});

  @override
  List<Object> get props => [];
}

class ArticleLoading extends ArticleState {}

class ArticleSuccess extends ArticleState {
  const ArticleSuccess(List<ArticleDataEntity>? articleList)
      : super(articleList: articleList);
}

class ArticleError extends ArticleState {
  const ArticleError(String? error) : super(error: error);
}
