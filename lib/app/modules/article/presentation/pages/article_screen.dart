import 'package:bloc_state_management/app/config/routes/my_routes.dart';
import 'package:bloc_state_management/app/modules/article/domain/entities/article_data_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/article_bloc.dart';
import '../widgets/article_query_drop_button_widget.dart';
import '../widgets/article_sortby_drop_button_widget.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ArticleBloc>(context).add(const ArticleEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "A R T I C L E",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ArticleSortByDropButtonWidget(),
                ArticleQueryDropButtonWidget(),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        bloc: BlocProvider.of<ArticleBloc>(context),
        builder: (context, state) {
          if (state is ArticleLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is ArticleSuccess) {
            final articleList = state.articleList;
            return ListView.builder(
              itemCount: articleList?.length ?? 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final article = articleList?[index];
                return InkWell(
                  onTap: () {
                    context.goNamed(
                      MyRoutes.articleDetail,
                      pathParameters: {'author': "${article?.author}"},
                      extra: article,
                    );
                  },
                  child: _buildCardArticle(article),
                );
              },
            );
          } else if (state is ArticleError) {
            return Text('Error: ${state.error}');
          }
          return const Text('No data available.');
        },
      ),
    );
  }

  Card _buildCardArticle(ArticleDataEntity? article) {
    String time = '';
    if (article?.publishedAt != null) {
      DateTime dateTime = DateTime.parse("${article?.publishedAt}");
      String month = DateFormat('MMMM').format(dateTime);
      int years = dateTime.year;
      int day = dateTime.day;
      time = '$day $month $years ';
    }

    return Card(
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                "${article?.urlToImage}",
                width: 80,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, event) => child,
                errorBuilder: (context, type, stack) {
                  return Container(
                    height: double.infinity,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.image_outlined,
                      size: 44.0,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${article?.source?.name}',
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '${article?.title}',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    time,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
