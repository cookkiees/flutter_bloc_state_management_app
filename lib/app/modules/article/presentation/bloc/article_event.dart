part of 'article_bloc.dart';

class ArticleEvent extends Equatable {
  final String? sortBy;
  final String? query;
  const ArticleEvent({this.sortBy, this.query});

  @override
  List<Object> get props => [];
}
