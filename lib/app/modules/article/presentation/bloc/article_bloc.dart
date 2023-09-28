import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/service_api_result_type.dart';
import '../../data/repository/article_repository_impl.dart';
import '../../domain/entities/article_data_entity.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepositoryImpl articleRepositoryImpl = ArticleRepositoryImpl();
  SortBy selectedSortBy = SortBy.popularity;
  ArticleBloc() : super(ArticleLoading()) {
    on<ArticleEvent>(_onArticle);
  }

  void _onArticle(ArticleEvent event, Emitter<ArticleState> emit) async {
    final String sortBy = event.sortBy ?? 'popularity';
    final String q = event.query ?? 'apple';
    try {
      emit(ArticleLoading());
      final response = await articleRepositoryImpl.getArticle(sortBy, q);
      if (response.result == ApiResultType.success) {
        final data = response.data;
        emit(ArticleSuccess(data!.articles));
      } else {
        emit(ArticleError(response.message!));
      }
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}

enum SortBy { popularity, publishedAt }

enum Query { apple, tesla }

extension SortByName on SortBy {
  String get name {
    switch (this) {
      case SortBy.popularity:
        return 'popularity';
      case SortBy.publishedAt:
        return 'publishedAt';
      default:
        throw Exception('Invalid SortBy value');
    }
  }
}

extension QueryByName on Query {
  String get name {
    switch (this) {
      case Query.apple:
        return 'apple';
      case Query.tesla:
        return 'tesla';
      default:
        throw Exception('Invalid SortBy value');
    }
  }
}
