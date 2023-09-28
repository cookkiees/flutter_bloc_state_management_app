import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/article_bloc.dart';

class ArticleSortByDropButtonWidget extends StatefulWidget {
  const ArticleSortByDropButtonWidget({super.key});

  @override
  ArticleSortByDropButtonWidgetState createState() =>
      ArticleSortByDropButtonWidgetState();
}

class ArticleSortByDropButtonWidgetState
    extends State<ArticleSortByDropButtonWidget> {
  SortBy selectedSortBy = SortBy.popularity;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      elevation: 1,
      dropdownColor: Colors.white,
      underline: const SizedBox.shrink(),
      value: selectedSortBy.name,
      onChanged: (String? newValue) {
        final sortBy = SortBy.values.firstWhere(
          (e) => e.name == newValue,
        );
        setState(() {
          selectedSortBy = sortBy;
        });
        BlocProvider.of<ArticleBloc>(context).add(ArticleEvent(
          sortBy: selectedSortBy.name,
        ));
      },
      items: <String>[SortBy.popularity.name, SortBy.publishedAt.name]
          .map((String value) {
        final entri = capitalizeFirstLetter(value);
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            entri,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }

  String capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
